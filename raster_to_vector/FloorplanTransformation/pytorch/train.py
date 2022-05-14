import torch
from torch.utils.data import DataLoader

from tqdm import tqdm
import numpy as np
import os
import cv2

from utils import *
from options import parse_args

from models.model import Model

from datasets.floorplan_dataset import FloorplanDataset
from IP import reconstructFloorplan

def main(options):
    if not os.path.exists(options.checkpoint_dir):
        os.system("mkdir -p %s"%options.checkpoint_dir)
    if not os.path.exists(options.test_dir):
        os.system("mkdir -p %s"%options.test_dir)

    dataset = FloorplanDataset(options, split='train', random=True)
    dataset_val = FloorplanDataset(options, split='val', random=False)

    print('the number of images', len(dataset))    

    dataloader = DataLoader(dataset, batch_size=options.batchSize, shuffle=True, num_workers=8)

    model = Model(options)
    model.cuda()
    model.train()

    if options.restore == 1:
        print('restore')
        # model.load_state_dict(torch.load(options.checkpoint_dir + '/checkpoint.pth'))
        model.load_state_dict(torch.load(options.checkpoint_dir + '/checkpoint.pth'))

    
    if options.task == 'test':
        dataset_test = FloorplanDataset(options, split='test', random=False)
        testOneEpoch(options, model, dataset_test)
        exit(1)
    
    optimizer = torch.optim.Adam(model.parameters(), lr = options.LR)
    if options.restore == 1 and os.path.exists(options.checkpoint_dir + '/optim.pth'):
        optimizer.load_state_dict(torch.load(options.checkpoint_dir + '/optim.pth'))
        pass

    last_loss = 10000
    curr_patience = 0
    for epoch in range(options.numEpochs):
        epoch_losses = []
        data_iterator = tqdm(dataloader, total=len(dataset) // options.batchSize + 1)
        for sampleIndex, sample in enumerate(data_iterator):
            optimizer.zero_grad()
            
            images, corner_gt, icon_gt, room_gt = sample[0].cuda(), sample[1].cuda(), sample[2].cuda(), sample[3].cuda()

            corner_pred, icon_pred, room_pred = model(images)
            #print([(v.shape, v.min(), v.max()) for v in [corner_pred, icon_pred, room_pred, corner_gt, icon_gt, room_gt]])
            #exit(1)
            #print(corner_pred.shape, corner_gt.shape)
            #exit(1)
            corner_loss = torch.nn.functional.binary_cross_entropy(corner_pred, corner_gt)
            icon_loss = torch.nn.functional.cross_entropy(icon_pred.view(-1, NUM_ICONS + 2), icon_gt.view(-1))
            room_loss = torch.nn.functional.cross_entropy(room_pred.view(-1, NUM_ROOMS + 2), room_gt.view(-1))
            losses = [corner_loss, icon_loss, room_loss]
            loss = sum(losses)

            loss_values = [l.data.item() for l in losses]
            epoch_losses.append(loss_values)
            status = str(epoch + 1) + ' loss: '
            for l in loss_values:
                status += '%0.5f '%l
                continue
            data_iterator.set_description(status)
            loss.backward()
            optimizer.step()

            # JOAO: commented out for running
            # if sampleIndex % 500 == 0:
            #     visualizeBatch(options, images.detach().cpu().numpy(), [('gt', {'corner': corner_gt.detach().cpu().numpy(), 'icon': icon_gt.detach().cpu().numpy(), 'room': room_gt.detach().cpu().numpy()}), ('pred', {'corner': corner_pred.max(-1)[1].detach().cpu().numpy(), 'icon': icon_pred.max(-1)[1].detach().cpu().numpy(), 'room': room_pred.max(-1)[1].detach().cpu().numpy()})])
            #     if options.visualizeMode == 'debug':
            #         exit(1)
            #         pass
            # continue
            images, corner_gt, icon_gt, room_gt =images.cpu(), corner_gt.cpu(), icon_gt.cpu(), room_gt.cpu() 
        print('loss', np.array(epoch_losses).mean(0))
        # if True:
        #     print('saving')
        #     torch.save(model.state_dict(), options.checkpoint_dir + '/checkpoint.pth')
        #     torch.save(optimizer.state_dict(), options.checkpoint_dir + '/optim.pth')
        #     pass

        val_loss = testOneEpoch(options, model, dataset_val)        
        print("last best: ", last_loss)
        print("current: ", val_loss)
        if val_loss > last_loss:
            curr_patience += 1
            if curr_patience == options.patience:
                break
        else:
            curr_patience = 0
            last_loss = val_loss
            print('saving')
            torch.save(model.state_dict(), options.checkpoint_dir + '/checkpoint.pth')
            torch.save(optimizer.state_dict(), options.checkpoint_dir + '/optim.pth')
        print("patience", curr_patience)
    return

def testOneEpoch(options, model, dataset):
    with torch.no_grad():
        model.eval()
        
        dataloader = DataLoader(dataset, batch_size=options.batchSize, shuffle=False, num_workers=1)
        
        epoch_losses = []    
        data_iterator = tqdm(dataloader, total=len(dataset) // options.batchSize + 1)
        epoch_accs = []
        for sampleIndex, sample in enumerate(data_iterator):

            images, corner_gt, icon_gt, room_gt = sample[0].cuda(), sample[1].cuda(), sample[2].cuda(), sample[3].cuda()
            
            corner_pred, icon_pred, room_pred = model(images)

            acc = (room_gt == room_pred.argmax(3)).sum()/(room_gt[0].shape[0]*room_gt[0].shape[1] * options.batchSize)
            corner_loss = torch.nn.functional.binary_cross_entropy(corner_pred, corner_gt)
            icon_loss = torch.nn.functional.cross_entropy(icon_pred.view(-1, NUM_ICONS + 2), icon_gt.view(-1))
            room_loss = torch.nn.functional.cross_entropy(room_pred.view(-1, NUM_ROOMS + 2), room_gt.view(-1))            
            losses = [corner_loss, icon_loss, room_loss]
            
            loss_values = [l.data.item() for l in losses]
            epoch_losses.append(loss_values)
            epoch_accs.append(acc.item())
            status = 'val loss: '
            for l in loss_values:
                status += '%0.5f '%l
                continue
            data_iterator.set_description(status)

            # JOAO: commented out for running
            # if sampleIndex % 500 == 0:
            #     visualizeBatch(options, images.detach().cpu().numpy(), [('gt', {'corner': corner_gt.detach().cpu().numpy(), 'icon': icon_gt.detach().cpu().numpy(), 'room': room_gt.detach().cpu().numpy()}), ('pred', {'corner': corner_pred.max(-1)[1].detach().cpu().numpy(), 'icon': icon_pred.max(-1)[1].detach().cpu().numpy(), 'room': room_pred.max(-1)[1].detach().cpu().numpy()})])            
            #     for batchIndex in range(len(images)):
            #         corner_heatmaps = corner_pred[batchIndex].detach().cpu().numpy()
            #         icon_heatmaps = torch.nn.functional.softmax(icon_pred[batchIndex], dim=-1).detach().cpu().numpy()
            #         room_heatmaps = torch.nn.functional.softmax(room_pred[batchIndex], dim=-1).detach().cpu().numpy()                
            #         reconstructFloorplan(corner_heatmaps[:, :, :NUM_WALL_CORNERS], corner_heatmaps[:, :, NUM_WALL_CORNERS:NUM_WALL_CORNERS + 4], corner_heatmaps[:, :, -4:], icon_heatmaps, room_heatmaps, output_prefix=options.test_dir + '/' + str(batchIndex) + '_', densityImage=None, gt_dict=None, gt=False, gap=-1, distanceThreshold=-1, lengthThreshold=-1, debug_prefix='test', heatmapValueThresholdWall=None, heatmapValueThresholdDoor=None, heatmapValueThresholdIcon=None, enableAugmentation=True)
            #         continue
            #     if options.visualizeMode == 'debug':
            #         exit(1)
            #         pass
            # continue

        val_loss = np.array(epoch_losses).mean(0)
        print('validation loss', val_loss)
        val_acc = np.array(epoch_accs).mean()
        print('validation acc', val_acc)

        total = sum(val_loss)
        model.train()
        return total

def visualizeBatch(options, images, dicts, indexOffset=0, prefix=''):
    #cornerColorMap = {'gt': np.array([255, 0, 0]), 'pred': np.array([0, 0, 255]), 'inp': np.array([0, 255, 0])}
    #pointColorMap = ColorPalette(20).getColorMap()
    images = ((images.transpose((0, 2, 3, 1)) + 0.5) * 255).astype(np.uint8)
    for batchIndex in range(len(images)):
        image = images[batchIndex].copy()
        filename = options.test_dir + '/' + str(indexOffset + batchIndex) + '_image.png'
        cv2.imwrite(filename, image)
        for name, result_dict in dicts:
            for info in ['corner', 'icon', 'room']:
                cv2.imwrite(filename.replace('image', info + '_' + name), drawSegmentationImage(result_dict[info][batchIndex], blackIndex=0, blackThreshold=0.5))
                continue
            continue
        continue
    return

if __name__ == '__main__':
    args = parse_args()
    
    # args.keyname = 'floorplan'
    # args.keyname += '_' + args.dataset
    args.keyname = ''

    if args.suffix != '':
        args.keyname += '_' + suffix
    
    args.checkpoint_dir = 'checkpoint/' + args.keyname
    args.test_dir = 'test/' + args.keyname

    print('keyname=%s task=%s started'%(args.keyname, args.task))

    main(args)
