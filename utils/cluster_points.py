import numpy as np

def cluster_values(values, distance_threshold):
    values = sorted(values)
    valuetoindex = dict()
    indextovalue = dict()
    indices_assigned = set()

    currentidx = 0
    for i1, x1 in enumerate(values):
        if i1 in indices_assigned:
            continue

        valuetoindex[x1] = currentidx
        indextovalue[currentidx] = [x1]
        indices_assigned.add(i1)

        for i2, x2 in enumerate(values):
            if i2 in indices_assigned: # i1 == i2 is redundant because i1 is pushed before
                continue

            if abs(x1 - x2) <= distance_threshold:
                valuetoindex[x2] = currentidx
                indextovalue[currentidx] = x2
                indices_assigned.add(i2)

        currentidx += 1

    return valuetoindex, indextovalue

def average_cluster(clusters):
    averagestoindex = {np.mean(j): i for (i, j) in clusters.items()}
    indextoaverages = {i: np.mean(j) for (i, j) in clusters.items()}

    return averagestoindex, indextoaverages

def normalize_wall_points(walls, distance_threshold=10):
    walls = [w.copy() for w in walls]
    allx = [w['points'][0][0]  for w in walls] + [w['points'][1][0] for w in walls]
    ally = [w['points'][0][1]  for w in walls] + [w['points'][1][1] for w in walls]

    xclusters = cluster_values(allx, distance_threshold)
    xaverages = average_cluster(xclusters[1])

    yclusters = cluster_values(ally, distance_threshold)
    yaverages = average_cluster(yclusters[1])

    for w in walls:
        p1x, p1y = tuple(w['points'][0])
        p2x, p2y = tuple(w['points'][1])

        p1x = xaverages[1][xclusters[0][p1x]]
        p1y = yaverages[1][yclusters[0][p1y]]

        p2x = xaverages[1][xclusters[0][p2x]]
        p2y = yaverages[1][yclusters[0][p2y]]

        points = sorted(((p1x, p1y), (p2x, p2y)), key=lambda x: (x[0], -x[1]))
        w['points'] = np.array(points)

    return walls
