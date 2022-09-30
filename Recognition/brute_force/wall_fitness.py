import sys, os.path as path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from utils.cluster_points import hcluster, mean_cluster
from utils.geometry import angle_between, angle_diff

import cv2
import numpy as np

def wall_to_poly(wall, width):
    """Generates the vertices to a given wall with two endpoints and a width."""
    v = wall[1] - wall[0]
    p = np.array([v[1], -v[0]])
    p = p / np.linalg.norm(p)

    p1 = wall[0] + p*(width/2)
    p2 = p1 + v
    p3 = p2 - p*width
    p4 = p3 - v

    return np.array([p1, p2, p3, p4])

def fitness(wall, wall_pixels, width):
    new_image = np.zeros(wall_pixels.shape)
    rect = wall_to_poly(wall, width)
    new_image = np.int0(cv2.fillConvexPoly(new_image, points = np.array(rect, dtype=np.int32), color = 255))//255

    i = np.sum(new_image & wall_pixels)
    total = np.sum(new_image)
    ratio = i/total
    return ratio

def warp_fitness(wall, wall_pixels, width):
    length = np.linalg.norm(wall[1] - wall[0])
    rect = wall_to_poly(wall, width)
    src = np.float32(rect[:3,:])
    dest = np.float32([[0, 0], [length, 0], [length, width]])
    M = cv2.getAffineTransform(src, dest)
    new_img = cv2.warpAffine(wall_pixels, M, (wall_pixels.shape[1], wall_pixels.shape[0]), cv2.INTER_NEAREST)
    new_img = cv2.getRectSubPix(new_img, np.intp([length, width]), (length//2, width//2))

    n_horizontal_pixels = np.sum(np.sum(new_img, axis=0) > 0)
    return n_horizontal_pixels/new_img.shape[1]

def get_junctions(heatmaps, wall_pixels, junction_threshold):
    wall_heatmaps = heatmaps[:13]
    junctions = wall_heatmaps.sum(axis=0) * wall_pixels
    junctions = np.where(junctions > junction_threshold, 1, 0)

    contours, _ = cv2.findContours(junctions.astype(np.uint8), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    centroids = []

    for c in contours:
        # Get the contours bounding rectangle:
        boundRect = cv2.boundingRect(c)

        # Get the centroid of the rectangle:
        cX = int(boundRect[0] + 0.5 * boundRect[2])
        cY = int(boundRect[1] + 0.5 * boundRect[3])
        centroids.append((cX, cY))

    return centroids

def normalize_points(all_points, distance_threshold):
    def sort_key(c):
        return (c[0], -c[1])

    allx = [p[0] for p in all_points]
    ally = [p[1] for p in all_points]

    xclusters = hcluster(allx, distance_threshold)
    xaverages = mean_cluster(xclusters[1])

    yclusters = hcluster(ally, distance_threshold)
    yaverages = mean_cluster(yclusters[1])

    res = []
    for px, py in all_points:
        px = xaverages[1][xclusters[0][px]]
        py = yaverages[1][yclusters[0][py]]

        res.append([px, py])

    with_original = zip(all_points, res)
    with_original = sorted(with_original, key=lambda p: sort_key(p[1]))
    original, normalized = [p[0] for p in with_original], [p[1] for p in with_original]
    return np.array(original).astype(np.intp), np.array(normalized).astype(np.intp)

def try_wall(c1, c2, o1, o2, wall_pixels, angles_put, angles_tried):
    angle = angle_between(c2 - c1, np.array([1, 0]))
    if any(angle_diff(a, angle) < 5 for a in angles_tried[tuple(c1)]): # do not points that go over tried junctios
        return False

    # 70 yields best results for the primary school floor plan, but it's hammered in
    if any(angle_diff(a, angle) < 70 for a in angles_put[tuple(c1)]): # do not add overlapping walls
        return False

    # We add this one immediatly because if not we could place a wall over two junction points, which
    # does not make sense
    angles_tried[tuple(c1)].add(angle)

    inter_threshold = 0.75
    # inter = loss(np.array((o1, o2)), wallPixels, 7, verbose_threshold=inter_threshold)
    # inter = fitness(np.array((o1, o2)), wall_pixels, 7)
    inter = warp_fitness(np.array((o1, o2)), wall_pixels, 7)
    if inter > inter_threshold:
        # Do not allow a wall going back the same direction (might happen if its further on the x axis)
        angles_put[tuple(c1)].add(angle)
        angles_put[tuple(c2)].add(angle_between(c1 - c2, np.array([1, 0])))

        return True
    return False

def get_walls(heatmaps, wall_pixels, junction_threshold=0.2, distance_threshold=5):
    junctions = get_junctions(heatmaps, wall_pixels//255, junction_threshold)
    originals, points = normalize_points(junctions, distance_threshold)

    walls = []

    angles_put = {tuple(p): set() for p in points}
    angles_tried = {tuple(p): set() for p in points}

    for i in range(len(points)-1):
        c1, o1 = points[i], originals[i]

        c2, o2 = points[i+1], originals[i+1]
        angle = angle_between(c2 - c1, np.array([1, 0]))
        if abs(angle - 90) < 5: # check if vertical
            if try_wall(c1, c2, o1, o2, wall_pixels, angles_put, angles_tried):
                walls.append((c1, c2))

        # find next that is horizontal
        c2 = [c2 for c2 in zip(points[i+1:], originals[i+1:]) if c1[1] == c2[0][1]]
        if c2 != []:
            c2, o2 = c2[0]
            if try_wall(c1, c2, o1, o2, wall_pixels, angles_put, angles_tried):
                walls.append((c1, c2))

        for j in range(i+1, len(points)):
            c2, o2 = points[j], originals[j]
            if try_wall(c1, c2, o1, o2, wall_pixels, angles_put, angles_tried):
                walls.append((c1, c2))

    return tuple(np.array(w).astype(np.float32) for w in walls)
