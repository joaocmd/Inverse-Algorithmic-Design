from torch import from_numpy, load, no_grad
from torch.nn import Module, Linear
from torchvision.models import convnext_tiny

import numpy as np
from .utils import resize_img

__all__ = ['Model']

class Net(Module):
    def __init__(self, classes):
        super().__init__()

        self.net = convnext_tiny(weights=None)
        in_features = self.net.classifier[2].in_features
        self.net.classifier[2] = Linear(in_features, len(classes))

    def forward(self, x):
        return self.net(x)

# Singleton wrapper for Net
class Model():

    models = {}

    def __init__(self, checkpoint, img_size, classes):
        self.model = Net(classes)
        self.model.load_state_dict(load(checkpoint))
        self.model.eval()
        self.model.cuda()
        self.img_size = img_size
        self.classes = classes

    @classmethod
    def get(cls, checkpoint, img_size, classes):
        if checkpoint not in cls.models:
            cls.models[checkpoint] = cls(checkpoint, img_size, classes)

        return cls.models[checkpoint]

    def predict(self, img):
        img = resize_img(img, self.img_size)
        img = from_numpy(np.moveaxis(img, 2, 0).reshape(1, 3, self.img_size, self.img_size))
        img = ((img / 255) * 2 - 1).float().cuda()
        with no_grad():
            prediction = self.model(img).argmax().item()
        return self.classes[prediction]
