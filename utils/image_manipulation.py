import cv2
import numpy as np

from utils.geometry import distance, vector

def pixels_to_bb(pixels):
    cnts, _ = cv2.findContours(pixels, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
    rectangles = (cv2.minAreaRect(cnt) for cnt in cnts)
    return tuple(cv2.boxPoints(rect) for rect in rectangles)


def as_image(map):
    return (map*255).astype(np.uint8)

def box_to_line(box):
    '''
        Converts a box described by 4 points to a line segment representing its
        longest side. The points are sorted with the y component inverted.
    '''
    if distance(box[0], box[1]) > distance(box[1], box[2]):
        return np.array(sorted(((box[0] + box[3])/2, (box[1] + box[2])/2), key=lambda p: (p[0], -p[1])))
    else:
        return np.array(sorted(((box[0] + box[1])/2, (box[2] + box[3])/2), key=lambda p: (p[0], -p[1])))

def get_room_contours_from_walls(wall_img, kernel_size=(3, 3)):
    '''
        Receives the segmented wall pixels and returns the polygons from
        skeletonization followed by contour extraction.
        Differs from the original paper because we use the thinned walls instead
        of the room contours.
    '''
    dilated = cv2.dilate(wall_img, np.ones(kernel_size))
    skeleton =  cv2.ximgproc.thinning(dilated)
    wall_cnts, _ = cv2.findContours(skeleton, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
    return tuple(c.reshape(c.shape[0], 2).astype(np.float32) for c in wall_cnts)#HACK: [:-1]

def get_opening_lines(opening_img, kernel_sie=(3, 3), size_threshold=10):
    '''
        Receives the segmented opening pixels (doors or windows) and returns
        their contourns. Performs dilations to avoid wrongful connections.
    '''
    eroded = cv2.erode(opening_img, np.ones(kernel_sie))
    cnts, _ = cv2.findContours(eroded, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
    rectangles = (cv2.minAreaRect(cnt) for cnt in cnts)
    boxes = (cv2.boxPoints(rect) for rect in rectangles)
    lines = (box_to_line(box) for box in boxes)
    return tuple(line for line in lines if np.linalg.norm(vector(line)) > size_threshold)