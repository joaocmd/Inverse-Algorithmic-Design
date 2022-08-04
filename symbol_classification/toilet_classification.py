from .utils import crop_box, checkpoint_path
from .model import Model
    
def classify_toilet(toilet, original_img):
    '''
        Predicts the rotation of the toilet with a granularity of 45 degrees.

        toilet: the bounding box representing the toilet
        original_img: original image pixels
    '''
    classes = tuple(str(c) for c in range(0, 360, 45))
    model = Model.get(checkpoint_path/'toilets.pth', 100, classes)
    cropped_toilet = crop_box(toilet, original_img)
    return model.predict(cropped_toilet)