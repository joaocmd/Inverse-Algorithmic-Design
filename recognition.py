import cv2
import numpy as np
from tqdm import tqdm

from door_classification.door_classification import classify_door
from toilet_classification import classify_toilet
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

def attach_openings(walls, elements, verbose=False):
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

def putText(img, text, pos, size=1):
    img = cv2.putText(
        img, text, pos,
        cv2.FONT_HERSHEY_SIMPLEX, size, (0, 0, 0), thickness=4, lineType=cv2.LINE_AA
    )
    img = cv2.putText(
        img, text, pos,
        cv2.FONT_HERSHEY_SIMPLEX, size, (255, 255, 255), thickness=2, lineType=cv2.LINE_AA
        # cv2.FONT_HERSHEY_SIMPLEX, 1, (102, 255, 102), thickness=2, lineType=cv2.LINE_AA
    )
    return img

def show_results(image, results, output_name):
    reconstr = np.copy(image)
    # reconstr = np.full(image.shape, 255).astype(np.uint8)
    for wall in results['walls']:
        s, e = wall['points']
        reconstr = cv2.line(reconstr, np.intp(s), np.intp(e), (66, 67, 66), 3)
        reconstr = cv2.circle(reconstr, np.intp(s), 3, (91, 93, 91), 3)
        reconstr = cv2.circle(reconstr, np.intp(e), 3, (91, 93, 91), 3)

    for wall in results['walls']:
        if 'elements' in wall:
            for el in wall['elements']:
                s, e = el['points']
                if el['type'] == 'window':
                    reconstr = cv2.line(reconstr, np.intp(s), np.intp(e), (57, 160, 237), 3)
                else:
                    reconstr = cv2.line(reconstr, np.intp(s), np.intp(e), (229, 178, 93), 3)

    icons = ('closet', 'toilet', 'sink', 'bathtub')
    colors = ((158, 107, 26), (133, 218, 255),  (58, 126, 156), (201, 30, 173))
    for icon in results['icons']:
        reconstr = cv2.drawContours(reconstr, [np.intp(icon['points'])], 0, colors[icons.index(icon['type'])], 3)

    for wall in results['walls']:
        if 'elements' in wall:
            for el in wall['elements']:
                if el['type'] == 'door':
                    centroid = np.intp(np.mean(el['points'], axis=0))
                    reconstr = putText(reconstr, el['orientation'][-2:], centroid, 1)

    for icon in results['icons']:
        if icon['type'] == 'toilet':
            centroid = np.intp(np.mean(icon['points'], axis=0))
            reconstr = putText(reconstr, str(icon['orientation']), centroid, 0.5)

    reconstr = cv2.cvtColor(reconstr, cv2.COLOR_RGB2BGR)
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
    elif method == 'r2v':
        from raster_to_vector import recognize
        prediction = recognize(path, verbose)

    walls, doors, windows = prediction['walls'], prediction['doors'], prediction['windows']
    walls = attach_openings(walls, doors + windows, verbose)
    walls = normalize_wall_points(walls, 5) # attach first because this might move walls slightly

    # this step can be merged with attach, probably not relevant
    logger.info('Classifying doors individually')
    for wall in tqdm(walls, disable=not verbose):
        if 'elements' in wall:
            for element in wall['elements']:
                if element['type'] == 'door':
                    element['orientation'] = classify_door(element, wall, original)

    # predicting toilet rotation
    logger.info('Classifying toilets individually')
    for icon in tqdm(prediction['icons'], disable=not verbose):
        if icon['type'] == 'toilet':
            icon['orientation'] = classify_toilet(icon, original)

    logger.info('Finished')
    res = {'walls': walls, 'icons': prediction['icons']}

    if verbose:
        path = path.split('.')
        show_results(original, res, f'{path[0]}_{method}.{path[1]}')

    return res


if __name__ == '__main__':
    # print(main('original.png', 'residential'))
    print(main('original.png', 'brute_force'))
    # print(main('r2v-image-rotated.jpg', 'r2v'))
