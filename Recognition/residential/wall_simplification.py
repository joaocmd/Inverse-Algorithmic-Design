import networkx as nx
import numpy as np

import sys, os.path as path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from utils.geometry import distance

def condition_x(n1, n2, delta):
    return distance(n1, n2) < delta

def condition_y(n, e, delta):
    p1, p2 = e
    p1, p2 = np.array(p1), np.array(p2)
    n = np.array(n)
    v1 = p1 - n
    v2 = p2 - n
    
    if np.dot(v1, v2) > 0: # if same direction
        return False
    
    return np.abs(np.cross(p2-p1,n-p1)/np.linalg.norm(p2-p1)) < delta    


def simplify_walls(g, deltax, deltay):
    g = g.copy()
    
    # x
    redo = True
    while redo:
        redo = False
        contracted = False
        for i, n1 in enumerate(g.nodes):
            for j, n2 in enumerate(g.nodes):
                if i == j:
                    continue
                
                if condition_x(n1, n2, deltax):
                    g = nx.contracted_nodes(g, n1, n2, self_loops=False)
                    new_node = ((n1[0]+n2[0])/2, ((n1[1]+n2[1])/2))
                    g = nx.relabel_nodes(g, {n1: new_node})

                    contracted = True
                    redo = True
                    break
            
            if contracted:
                contracted = False
                break
    
    # y
    redo = True
    while redo:
        redo = False
        contracted = False
        for e in g.edges:
            for n in g.nodes:
                if n in e: # if the node is connected to the edge
                    continue
                
                if condition_y(n, e, deltay):
                    g.remove_edge(e[0], e[1])
                    g.add_edge(n, e[0])
                    g.add_edge(n, e[1])

                    contracted = True
                    redo = True
                    break
            
            if contracted:
                contracted = False
                break
    
    return g

def contours_to_walls(cnts, deltax=10, deltay=7):
    G = nx.Graph()
    for polygon in cnts:
        G.add_node(tuple(polygon[0]))
        for v in range(len(polygon) - 1):
            G.add_node(tuple(polygon[v+1]))
            G.add_edge(tuple(polygon[v]), tuple(polygon[v+1]))
        G.add_edge(tuple(polygon[-1]), tuple(polygon[0]))

    # Center line optimization
    while True:#checkConditionX(G) or checkConditionY(G):
        G = simplify_walls(G, deltax, deltay)
        break

    return tuple(np.array(e).astype(np.float32) for e in G.edges)