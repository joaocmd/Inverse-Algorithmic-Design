from .FloorplanTransformation.predict import main

import numpy as np
import cv2

import logging

def transform_points(img_path, elements):
    image = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
    # image = imutils.resize(image, 256, 256)
    height, width = image.shape
    diff = height-width

    height_factor, width_factor = height/255, width/255
    if diff > 0:
        height_factor = height/255
        width_factor = (width + diff)/255
    else:
        height_factor = (height - diff)/255
        width_factor = width/255

    scale_factor = np.array((width_factor, height_factor))

    elements = tuple({**e, 'points': e['points']*scale_factor} for e in elements)

    if diff > 0:
        elements = tuple({**e, 'points': e['points']+np.array([-diff//2, 0])} for e in elements)
    elif diff < 0:
        elements = tuple({**e, 'points': e['points']+np.array([0, diff//2])} for e in elements)

    return elements

def recognize(image, verbose):
    logger = logging.getLogger(__name__)
    if verbose: logger.setLevel(logging.DEBUG)

    logger.info('Performing segmentation')
    results = main(image, False)

    walls = tuple({'points': np.array((w[0], w[1]))} for w in  results['walls'])
    walls = transform_points(image, walls)

    doors = tuple({'points': np.array(d), 'type': 'door'}  for d in results['doors'])
    doors = transform_points(image, doors)

    return {'walls': walls, 'doors': doors, 'windows': (), 'icons': results['icons']}
