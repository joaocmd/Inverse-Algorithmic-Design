import sys, os.path as path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))

from utils.image_manipulation import *
from .room_contour_simplification import simplify_contours
from .wall_simplification import contours_to_walls
from segmentation import predict

import logging
from tqdm import tqdm

def recognize(image, verbose):
    logger = logging.getLogger(__name__)
    if verbose: logger.setLevel(logging.DEBUG)

    logger.info('Performing segmentation')
    rooms_pred, icons_pred, heatmaps = predict(image)
    # Structural elements
    walls_closed = as_image(rooms_pred == 2)
    doors_pixels = as_image(icons_pred ==  2)
    windows_pixels = as_image(icons_pred ==  1)

    # Decorative elements
    closets_pixels = as_image(icons_pred == 3)
    toilets_pixels = as_image(icons_pred == 5)
    sinks_pixels = as_image(icons_pred == 6)
    bathtubs_pixels = as_image(icons_pred == 9)

    ## Vectorization and adding semantics
    logger.info('Simplifying contours')
    room_cnts = get_room_contours_from_walls(walls_closed)
    room_cnts = simplify_contours(room_cnts)

    logger.info('Converting polygons to walls')
    walls = contours_to_walls(room_cnts)
    walls = tuple({'points': w} for w in tqdm(walls, disable=not verbose))

    logger.info('Identifying wall openings and associating them with their respective walls')
    doors = get_opening_lines(doors_pixels)
    doors = tuple({'points': d, 'type': 'door'} for d in doors)

    windows = get_opening_lines(windows_pixels)
    windows = tuple({'points': w, 'type': 'window'} for w in windows)

    logger.info('Retrieving icons')
    closets = tuple({'points': p, 'type': 'closet'} for p in pixels_to_bb(closets_pixels))
    toilets = tuple({'points': p, 'type': 'toilet'} for p in pixels_to_bb(toilets_pixels))
    sinks = tuple({'points': p, 'type': 'sink'} for p in pixels_to_bb(sinks_pixels))
    bathtubs = tuple({'points': p, 'type': 'bathtub'} for p in pixels_to_bb(bathtubs_pixels))

    logger.info('Finished')
    return {'walls': walls, 'doors': doors, 'windows': windows, 'symbols': (*closets, *toilets, *sinks, *bathtubs)}, walls_closed