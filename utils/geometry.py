import numpy as np

def angle_diff(a, b):
    angle = abs(a - b)
    return 360 - angle if angle > 180 else angle

def angle_between(a, b):
    angle = np.degrees(np.arctan2(a[0]*b[1] - a[1]*b[0], a[0]*b[0] + a[1]*b[1]))
    return angle if angle >= 0 else angle + 360

def distance(p1, p2):
    return np.linalg.norm(np.array(p1) - np.array(p2))

def cos_sim(a, b):
    return np.dot(a, b)/(np.linalg.norm(a)*np.linalg.norm(b))

def segment(p, q):
    return np.vstack([p, q])

def center(s):
    return (s[0] + s[1])/2

def normalized(v):
    return v / np.linalg.norm(v)

def perpendicular(v):
    return normalized(np.array([-v[1], v[0]]))

def vector(s):
    return s[1] - s[0]

# https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
def intersect(s1, s2):
    def on_segment(p, s):
        '''checks wheter point p is on segment s'''
        return (s[0][0] <= max(p[0], s[1][0]) and s[0][0] >= min(p[0], s[1][0]) and
                s[0][1] <= max(p[1], s[1][1]) and s[0][1] >= min(p[1], s[1][1]))
    
    def orientation(p, q, r):
        val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])

        if val == 0:  # colinear
            return 0
        return 1 if val > 0 else 2 # clock or counterclock wise
 

    # Find the 4 orientations required for
    # the general and special cases

    p1, q1, p2, q2 = s1[0], s1[1], s2[0], s2[1]

    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, q2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)

        # General case
    if o1 != o2 and o3 != o4:
        return True

    # Special Cases
    # p1, q1 and p2 are collinear and p2 lies on segment p1q1
    if o1 == 0 and on_segment(p1, (p2, q1)):
        return True

    # p1, q1 and q2 are collinear and q2 lies on segment p1q1
    if o2 == 0 and on_segment(p1, segment(q2, q1)):
        return True

    # p2, q2 and p1 are collinear and p1 lies on segment p2q2
    if o3 == 0 and on_segment(p2, segment(p1, q2)):
        return True

    # p2, q2 and q1 are collinear and q1 lies on segment p2q2
    if o4 == 0 and on_segment(p2, segment(q1, q2)):
        return True

    return False # Doesn't fall in any of the above cases