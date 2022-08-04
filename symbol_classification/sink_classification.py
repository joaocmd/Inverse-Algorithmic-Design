from .utils import crop_box, checkpoint_path
from .model import Model

def classify_sink(sink, original_img):
    '''
        Predicts the rotation of the sink with a granularity of 45 degrees.

        toilet: the bounding box representing the toilet
        original_img: original image pixels
    '''
    classes = tuple(str(c) for c in range(0, 360, 45)) + ('corner', )
    model = Model.get(checkpoint_path/'sinks.pth', 100, classes)
    cropped_sink = crop_box(sink, original_img)
    return model.predict(cropped_sink)