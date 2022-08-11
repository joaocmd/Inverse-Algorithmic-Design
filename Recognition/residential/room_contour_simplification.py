import sys, os.path as path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from utils.geometry import distance, cos_sim

import numpy as np
import cv2

def condition_a(p1, p2, delta=0.5):
    return distance(p1, p2) < delta
    
def check_condition_a(points):
    for i in range(len(points)-1):
        if condition_a(points[i], points[i+1]):
            return True
    return False

def condition_b(p0, p1, p2, delta=np.cos(np.radians(10))):
    if np.linalg.norm(p1 - p0) == 0 or np.linalg.norm(p2 - p1) == 0:
        return False # HACK: this might happen because, it is fixed on the wall step
    return np.abs(cos_sim(p1 - p0, p2 - p1)) > delta

def check_condition_b(points):
    for i in range(len(points)-2):
        if condition_b(points[i], points[i+1], points[i+2]):
            return True
    return False

def simplify_polygon(p):
    p = np.copy(p)
    
    # a
    redo = True
    while redo:
        redo = False
        for i in range(len(p)-1):  
            if condition_a(p[i], p[i+1]):
                p[i] = (p[i] + p[i+1])/2
                p = np.delete(p, i+1, 0)
                redo = True
                break
    
    # b
    redo = True
    while redo:
        redo =  False
        for i in range(len(p)-2):
            if condition_b(p[i], p[i+1], p[i+2]):
                p = np.delete(p, i+1, 0)
                redo = True
                break
    return p

def simplify_contours(cnts, DP_threshold=10, perimeter_threshold=50):
    new_cnts = []

    for cnt in cnts:
        perimeter = cv2.arcLength(cnt, True)
        approx = cv2.approxPolyDP(cnt, DP_threshold, True)
        if perimeter > perimeter_threshold:
            new_cnts.append(approx.reshape(approx.shape[0], 2).astype(np.float32))

    # Room contour optimization
    # for i, _ in enumerate(cnts):
    #     while check_condition_a(cnts[i]) or check_condition_b(cnts[i]):
    #         # TODO: optimize...
    #         cnts[i] = simplify_polygon(cnts[i])

    # for i, c in enumerate(cnts):
    #     cnts[i] = c.reshape((cnts[i].shape[0], 1, 2)).astype(np.int32)

    return  tuple(new_cnts)