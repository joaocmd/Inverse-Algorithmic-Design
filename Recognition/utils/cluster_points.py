import numpy as np
from sklearn.cluster import AgglomerativeClustering

def hcluster(values, distance_threshold):
    values = np.array([[v] for v in sorted(values)])

    model = AgglomerativeClustering(n_clusters=None,
                                    linkage='complete',
                                    distance_threshold=distance_threshold)
    clusters = model.fit_predict(values)

    valuetoindex = {values[i][0]: clusters[i] for i in range(len(values))}
    indextovalues = {i: [v[0] for v in values[np.where(clusters==i)]] for i in np.unique(clusters)}
    return valuetoindex, indextovalues

def mean_cluster(clusters):
    averagestoindex = {np.mean(j): i for (i, j) in clusters.items()}
    indextoaverages = {i: np.mean(j) for (i, j) in clusters.items()}

    return averagestoindex, indextoaverages

def normalize_wall_points(walls, distance_threshold=10):
    walls = [w.copy() for w in walls]
    allx = [w['points'][0][0]  for w in walls] + [w['points'][1][0] for w in walls]
    ally = [w['points'][0][1]  for w in walls] + [w['points'][1][1] for w in walls]

    xclusters = hcluster(allx, distance_threshold)
    xaverages = mean_cluster(xclusters[1])

    yclusters = hcluster(ally, distance_threshold)
    yaverages = mean_cluster(yclusters[1])

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
