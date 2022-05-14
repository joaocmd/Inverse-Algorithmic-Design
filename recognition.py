import cv2
import numpy as np
from tqdm import tqdm

from residential.room_contour_simplification import simplify_contours
from residential.wall_simplification import contours_to_walls
from door_classification.door_classification import classify_door
from segmentation import predict
from utils.wall_width_calculation import calculate_width
from utils.cluster_points import normalize_wall_points
from utils.geometry import *

import logging
import uuid

# TODO
#   ideias:
#       * find which room is connected to each wall and define rooms as functions (repeated walls are ignored and kept in a global state)
#       * find most common door width and declare as a state variable so that it can be hidden in the function call of most walls
#           (probably useful for other cases such as door length, etc.)   

class HashableDict:
    def __init__(self, value):
        self.value = value
        self.id = uuid.uuid1() # HACK: dirty
    
    def __hash__(self):
        return hash(self.id)

    def __getitem__(self, key):
        return self.value[key]

    def __setitem__(self, key, value):
        self.value[key] = value


def element_segment(s):
    '''
        Returns a line segment perpendicular to the given segment. Used to detect
        collisions between walls and wall elements. 
    '''
    width = 10
    half_width = width/2

    c = center(s)
    normal = perpendicular(vector(s))

    return segment(c - normal*half_width, c + normal*half_width)

def attach_openings(walls, elements, verbose):
    '''
        Changes walls destructively.
    '''

    elements = set([HashableDict(e) for e in elements])
    for wall in tqdm(walls, disable=not verbose):
        elements_to_remove = []
        wall_segment = wall['points']

        for element in elements:
            perpendicular_element = element_segment(element['points'])
            
            if intersect(wall_segment, perpendicular_element):
                elements_to_remove.append(element)
                if 'elements' not in wall:
                    wall['elements'] = []

                wall['elements'].append(element.value)

        for element in elements_to_remove:
            elements.remove(element)

    return walls

def show_results(image, results, output_name):
    reconstr = np.copy(image) #np.full(image.shape, 255).astype(np.uint8)
    for wall in results['walls']:
        s, e = wall['points']
        reconstr = cv2.line(reconstr, np.intp(s), np.intp(e), (0, 0, 0), 3)
        reconstr = cv2.circle(reconstr, np.intp(s), 3, (0, 255, 0), 3)
        reconstr = cv2.circle(reconstr, np.intp(e), 3, (0, 255, 0), 3)

        if 'elements'  in wall:
            for el in wall['elements']:
                s, e = el['points']
                if el['type'] == 'window':
                    reconstr = cv2.line(reconstr, np.intp(s), np.intp(e), (147, 181, 198), 3)
                else:
                    reconstr = cv2.line(reconstr, np.intp(s), np.intp(e), (94, 80, 63), 3)
                    reconstr = cv2.putText(
                        reconstr, el['type'][-2:],
                        np.intp(s),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (230, 80, 63), 3, 2
                    )

    icons = ('closet', 'toilet', 'sink', 'bathtub')
    colors = ((145, 91, 36), (133, 218, 255),  (58, 126, 156), (201, 30, 173))
    for icon in results['icons']:
        reconstr = cv2.drawContours(reconstr, [np.intp(icon['points'])], 0, colors[icons.index(icon['type'])], 3)

    cv2.imwrite(output_name, reconstr)

def main(path, method, verbose=True):
    logging.basicConfig(format='%(asctime)s %(levelname)s - %(message)s')
    logger = logging.getLogger(__name__)
    if verbose:
        np.seterr(all='raise')
        logger.setLevel(logging.DEBUG)
    
    logger.info('Starting recognition')
    original = cv2.cvtColor(cv2.imread(path), cv2.COLOR_BGR2RGB)

    if method == 'residential':
        from residential import recognize
        prediction = recognize(original, verbose)
    elif method == 'brute_force':
        from brute_force import recognize
        prediction = recognize(original, verbose)

    walls, doors, windows = prediction['walls'], prediction['doors'], prediction['windows']
    walls = attach_openings(walls, doors + windows, verbose)
    walls = normalize_wall_points(walls, 5)

    # this step can be merged with attach, probably not relevant
    logger.info('Classifying doors individually')
    for wall in tqdm(walls, disable=not verbose):
        if 'elements' in wall:
            for element in wall['elements']:
                if element['type'] == 'door':
                    element['type'] = classify_door(element, wall, original)

    logger.info('Finished')
    res = {'walls': walls, 'icons': prediction['icons']}

    if verbose:
        path = path.split('.')
        show_results(original, res, f'{path[0]}_{method}.{path[1]}')

    return res


if __name__ == '__main__':
    # print(main('original.png', 'residential'))
    print(main('original.png', 'brute_force'))
