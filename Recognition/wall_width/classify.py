from scipy.optimize import differential_evolution
import numpy as np
import cv2

def wall_to_poly(wall, width):
    """
        Generates the vertices to a given wall with two endpoints and a width.
    """
    v = wall[1] - wall[0]
    p = np.array([v[1], -v[0]])
    if np.linalg.norm(p) == 0:
        return None
    p = p / np.linalg.norm(p)

    p1 = wall[0] + p*(width/2)
    p2 = p1 + v
    p3 = p2 - p*width
    p4 = p3 - v

    return np.array([p1, p2, p3, p4])


def wall_width_iou(wall, wall_pixels, width):
    new_image = np.zeros(wall_pixels.shape)
    rect = wall_to_poly(wall, width)
    if rect is None:
        return 0

    new_image = np.int0(cv2.fillConvexPoly(new_image, points = np.array(rect, dtype=np.int32), color = 255))//255

    # crop to RoI
    x, y, w, h = cv2.boundingRect(np.array(wall_to_poly(wall, 100), dtype=np.int32))
    new_image = new_image[y:y+h, x:x+w]
    wall_pixels = wall_pixels[y:y+h, x:x+w]

    i = np.sum(new_image & wall_pixels)
    u = np.sum(new_image | wall_pixels)
    return i/u

def wall_fitness(wall, wall_pixels, width):
    new_image = np.zeros(wall_pixels.shape)
    rect = wall_to_poly(wall['points'], width)
    if rect is None:
        return -np.NINF

    new_image = np.int0(cv2.fillConvexPoly(new_image, points = np.array(rect, dtype=np.int32), color = 255))//255


    i = np.sum(new_image & wall_pixels)
    neg = ~wall_pixels + 2
    negative_i = np.sum(new_image & neg)
    return i - 1.1*negative_i

def objective(x, wall, wall_pixels):
    return -wall_fitness(wall, wall_pixels, int(round(x[0])))

def get_wall_width_evolution(wall, wall_segmentation):
    obj = lambda x: objective(x, wall, wall_segmentation)
    solution = differential_evolution(obj, bounds=[(1, 30)])

    return int(round(solution.x[0]))

def get_wall_width(wall, wall_segmentation):
    scores = [(x, wall_fitness(wall, wall_segmentation, x)) for x in range(1, 30)]
    return max(scores, key=lambda s: s[1])[0]