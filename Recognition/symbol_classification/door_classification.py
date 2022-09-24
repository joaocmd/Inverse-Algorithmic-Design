import cv2
import numpy as np

import sys, os.path as path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from utils.geometry import perpendicular, normalized, vector, center

from .model import Model
from .utils import checkpoints_path

def get_wall_direction(wall, p):
    '''
        Gets direction of `wall` at point `p`.
        TODO: generalize to functions.
    '''
    return  normalized(vector(wall['points']))

def crop_door(door, wall, img, padding=15):
    centroid = center(door['points'])
    width = np.linalg.norm(vector(door['points']))

    v = get_wall_direction(wall, centroid)
    n = perpendicular(v)
    s, e = centroid - (v*width/2), centroid + (v*width/2)
    t = centroid + n

    dst = np.array([[padding, padding+width], [padding+width, padding+width], [width/2+padding, padding+width+1]]) # t is on unit vector
    M = cv2.getAffineTransform(np.float32(np.array([s, e, t])), np.float32(dst))

    rotated = cv2.warpAffine(img, M, (img.shape[1], img.shape[0]), cv2.INTER_CUBIC, borderMode = cv2.BORDER_CONSTANT, borderValue=[1, 1, 1])
    cropped = cv2.getRectSubPix(rotated, np.int0(np.array([width+2*padding, 2*(width+padding)])), (width/2+padding, padding+width))
    return cropped

def classify_door(door, wall, original_img):
    '''
        The direction of the door depends on the wall vector, they might differ
        because of slight errors during recognition, and it might flip directions
        when the segment is practically vertical.

        segment: the line segment representing the door
        wall: the corresponding wall
        original_img: original image pixels
    '''
    # classes = (
    #     'slide', 'rollup', 'none',
    #     'double_d', 'double_u',
    #     'opposite_ul_dl', 'opposite_ul_dr', 'opposite_ur_dl', 'opposite_ur_dr',
    #     'single_dl', 'single_dr', 'single_ul', 'single_ur',
    # )
    classes = (
        'none', 'slide', 'rollup',
        'double_r', 'double_f',
        'opposite_lf_lr', 'opposite_lf_rr', 'opposite_rf_lr', 'opposite_rf_rr',
        'single_lr', 'single_rr', 'single_lf', 'single_rf',
    )

    model = Model.get(checkpoints_path/'doors.pth', 40, classes)
    cropped_door = crop_door(door, wall, original_img)
    return model.predict(cropped_door)
