from torch import from_numpy, load, no_grad, tensor
from torch.nn import Module, Linear
from torchvision.models import convnext_tiny

import cv2
import pathlib
import numpy as np

__all__ = ['Model']

classes = (
    'slide', 'rollup', 'none',
    'double_d', 'double_u',
    'opposite_ul_dl', 'opposite_ul_dr', 'opposite_ur_dl', 'opposite_ur_dr',
    'single_dl', 'single_dr', 'single_ul', 'single_ur',
)

class_map = {
    'Door Fold Beside': classes.index('slide'),
    'Door None Beside': classes.index('none'),
    'Door ParallelSlide Beside': classes.index('slide'),
    'Door RollUp Beside': classes.index('rollup'),
    'Door Slide Beside': classes.index('slide'),
    'Door Zfold Beside': classes.index('slide'),
    'Double_d': classes.index('double_d'),
    'Double_u': classes.index('double_u'),
    'Opposite_ul_dl': classes.index('opposite_ul_dl'),
    'Opposite_ul_dr': classes.index('opposite_ul_dr'),
    'Opposite_ur_dl': classes.index('opposite_ur_dl'),
    'Opposite_ur_dr': classes.index('opposite_ur_dr'),
    'Single_dl': classes.index('single_dl'),
    'Single_dr': classes.index('single_dr'),
    'Single_ul': classes.index('single_ul'),
    'Single_ur': classes.index('single_ur'),
}

img_size = 40

def resize(image):
    height, width, _ = image.shape
    diff = height-width
    if diff > 0:
        image = cv2.copyMakeBorder(image, 0, 0, diff//2, diff//2, borderType=cv2.BORDER_CONSTANT, value=[255, 255, 255])
    elif diff < 0:
        image = cv2.copyMakeBorder(image, -diff//2, -diff//2, 0, 0, borderType=cv2.BORDER_CONSTANT, value=[255, 255, 255])
    image = cv2.resize(image, (img_size, img_size), interpolation=cv2.INTER_AREA)
    return image

class Net(Module):
    def __init__(self):
        super().__init__()
        self.net = convnext_tiny(weights=None)
        in_features = self.net.classifier[2].in_features
        self.net.classifier[2] = Linear(in_features, len(classes))

    def forward(self, x):
        return self.net(x)

# Singleton wrapper for Net
class Model(Net):
    def __new__(cls):
        if not hasattr(cls, 'instance'):
            model = Net()
            model.load_state_dict(load(pathlib.Path(__file__).parent.resolve()/'doors.pth'))
            model.eval()
            cls.instance = model
        return cls.instance

    @classmethod
    def predict(cls, img):
        model = cls()
        img = resize(img)
        img = from_numpy(np.moveaxis(img, 2, 0).reshape(1, 3, img_size, img_size))
        img = ((img / 255) * 2 - 1).float()
        with no_grad():
            prediction = model(img).argmax().item()
        return classes[prediction]

