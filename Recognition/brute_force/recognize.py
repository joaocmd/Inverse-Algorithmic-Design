import sys, os.path as path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))

from utils.image_manipulation import *
from .wall_fitness import get_walls
from segmentation import predict

import logging
from tqdm import tqdm
import time

def recognize(image, verbose):
    logger = logging.getLogger(__name__)
    if verbose: logger.setLevel(logging.DEBUG)

    logger.info('Performing segmentation')
    start = time.perf_counter()
    rooms_pred, icons_pred, heatmaps = predict(image)
    segmentation_time = time.perf_counter() - start
    # Structural elements
    walls_closed = as_image(rooms_pred == 2)
    railing_pixels = as_image(rooms_pred == 8)
    doors_pixels = as_image(icons_pred ==  2)
    windows_pixels = as_image(icons_pred ==  1)

    # Decorative elements
    closets_pixels = as_image(icons_pred == 3)
    toilets_pixels = as_image(icons_pred == 5)
    sinks_pixels = as_image(icons_pred == 6)
    bathtubs_pixels = as_image(icons_pred == 9)

    ## Vectorization and adding semantics
    logger.info('Extracting walls')
    start = time.perf_counter()
    walls = get_walls(heatmaps, walls_closed, multiply_maps=True)
    walls = tuple({'points': w} for w in walls)

    railings = get_walls(heatmaps, railing_pixels, multiply_maps=False)
    railings = tuple({'points': r} for r in railings)

    logger.info('Identifying wall openings and associating them with their respective walls')
    doors = get_opening_bb(doors_pixels)
    doors = tuple({'points': d, 'type': 'door'} for d in doors)

    windows = get_opening_bb(windows_pixels)
    windows = tuple({'points': w, 'type': 'window'} for w in windows)

    logger.info('Retrieving symbols')
    closets = tuple({'points': p, 'type': 'closet'} for p in pixels_to_bb(closets_pixels))
    toilets = tuple({'points': p, 'type': 'toilet'} for p in pixels_to_bb(toilets_pixels))
    sinks = tuple({'points': p, 'type': 'sink'} for p in pixels_to_bb(sinks_pixels))
    bathtubs = tuple({'points': p, 'type': 'bathtub'} for p in pixels_to_bb(bathtubs_pixels))

    vectorization_time = time.perf_counter() - start

    logger.info('Finished')
    return {
                'walls': walls, 'railings': railings, 'doors': doors, 'windows': windows, 'symbols': (*closets, *toilets, *sinks, *bathtubs),
                'segmentation': { 'rooms': rooms_pred, 'icons': icons_pred, 'walls': walls_closed, 'railings': railing_pixels, 'heatmaps': heatmaps[:13].max(axis=0) },
                'times': { 'segmentation': segmentation_time, 'vectorization': vectorization_time}
        }