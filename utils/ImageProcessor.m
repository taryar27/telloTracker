%% ImageProcessor Class
% Feature detector class that returns bounding boxes of objets detected.
% The objects to be detected can be tuned by changing the detector in the
% class constructor.

classdef ImageProcessor < handle
    properties (SetAccess = private)
        detector; % feature detector to detect front upright faces (can be changed)
        shapeInserter; % property to insert bounding box for the features detected
    end
    
    methods
        % Creates an ImageProcessor class with preset detector and
        % shapeInserters. The detector has to be tuned for best results. For
        % more information to tune the detector, refer to
        % vision.CascadeObjectDetector documentations.
        function self = ImageProcessor()
            self.detector = vision.CascadeObjectDetector('ClassificationModel', 'FrontalFaceCART', 'MergeThreshold', 6, 'MinSize', [50 50]);
            self.shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 0 0]);
        end
        
        % input: image, an image from a camera.
        % output: returns an array of a newly constructed image and the
        % coordinates of the bounding box.
        function [new_img, bbox] = detect(self, image)
            bbox = step(self.detector, image);
            new_img = step(self.shapeInserter, image, int32(bbox));
        end
        
    end
end