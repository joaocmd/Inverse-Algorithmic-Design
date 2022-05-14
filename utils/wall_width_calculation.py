import cv2
import utils as np

from scipy.optimize import differential_evolution
# import scipy.spatial.distance as scidistance

def wall_to_poly(wall, width):
    '''
        Generates the vertices to a given wall with two endpoints and a width.
        cv2.line has rounded corners, we use this instead to rasterize the walls
    '''
    v = wall[1] - wall[0]
    p = np.array([v[1], -v[0]])
    p = p / np.linalg.norm(p)
    
    p1 = wall[0] + p*(width/2)
    p2 = p1 + v
    p3 = p2 - p*width
    p4 = p3 - v
    
    return np.array([p1, p2, p3, p4])


# def wallWidthIOU(wall, wall_pixels, width):
#     new_img = np.zeros(wall_pixels.shape)
#     rect = wall_to_poly(wall, width)
#     new_img = np.int0(cv2.fillConvexPoly(new_img, points = np.array(rect, dtype=np.int32), color = 255))//255
    
#     # crop to RoI
#     x,y,w,h = cv2.boundingRect(np.array(wall_to_poly(wall, 100), dtype=np.int32))
#     new_img = new_img[y:y+h, x:x+w]
#     wall_pixels = wall_pixels[y:y+h, x:x+w]

#     i = np.sum(new_img & wall_pixels)
#     u = np.sum(new_img | wall_pixels)
#     return i/u
      
#     return 1 - scidistance.jaccard(new_img.flatten(), wall_pixels.flatten())
# 
#     # dice coefficient
#     intersection = 2*np.sum(newImage & wallPixels)
#     union = np.sum(newImage) + np.sum(wallPixels)

def fitness(wall, wall_pixels, width):
    new_img = np.zeros(wall_pixels.shape)
    rect = wall_to_poly(wall, width)
    new_img = np.int0(cv2.fillConvexPoly(new_img, points = np.array(rect, dtype=np.int32), color = 255))//255
    

    intersection = np.sum(new_img & wall_pixels)
    neg = ~wall_pixels + 2
    negative_intersection = np.sum(new_img & neg)
    return intersection - negative_intersection

def calculate_width(wall, wall_pixels):
    def objective(x, wall, wall_pixels):
        return -fitness(wall, wall_pixels, int(round(x[0])))
    

    wall = np.array(wall)
    solution = differential_evolution(lambda x: objective(x, wall, wall_pixels), bounds=[(1, 40)]) # TODO: tweak
    return round(solution.x[0])