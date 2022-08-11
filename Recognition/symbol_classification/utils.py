import numpy as np
import cv2
import pathlib

checkpoint_path = pathlib.Path(__file__).parent.resolve()/'checkpoints'

def crop_box(toilet, img, padding=10):
    xx = [p[0] for p in toilet['points']]
    yy = [p[1] for p in toilet['points']]
    min_y, top_x = int(np.min(yy)), int(np.min(xx))
    max_y, bottom_x = int(np.max(yy)), int(np.max(xx))

    cropped = img[min_y-padding:max_y+padding+1, top_x-padding:bottom_x+padding+1]
    return cropped

def resize_img(image, img_size):
    height, width, _ = image.shape
    diff = height-width
    if diff > 0:
        image = cv2.copyMakeBorder(image, 0, 0, diff//2, diff//2, borderType=cv2.BORDER_CONSTANT, value=[255, 255, 255])
    elif diff < 0:
        image = cv2.copyMakeBorder(image, -diff//2, -diff//2, 0, 0, borderType=cv2.BORDER_CONSTANT, value=[255, 255, 255])
    image = cv2.resize(image, (img_size, img_size), interpolation=cv2.INTER_AREA)
    return image