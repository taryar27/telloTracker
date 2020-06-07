%% ImageProcessor Class
% Feature detector class that returns bounding boxes of objets detected.
% The objects to be detected can be tuned by changing the detector in the
% class constructor.

classdef ImageProcessor < handle
    properties (SetAccess = private)
        target = [537 151 226 226]; % Target points for the bounding box
        detector; % feature detector to detect front upright faces (can be changed)
        shapeInserter; % property to insert bounding box for the features detected
    end
    
    methods
        % Creates an ImageProcessor class with preset detector and
        % shapeInserters. The detector has to be tuned for best results. For
        % more information to tune the detector, refer to
        % vision.CascadeObjectDetector documentations.
        function self = ImageProcessor(target)
            if nargin == 1
                self.target = target;
            else
                self.target = [537 151 226 226];
            end
            
            self.detector = vision.CascadeObjectDetector('ClassificationModel', 'FrontalFaceCART', 'MergeThreshold', 4, 'MinSize', [100 100]);
        end
        
        % input: image, an image from a camera.
        % output: returns an array of a newly constructed image and the
        % coordinates of the bounding box.
        function [new_img, bbox] = detect(self, image)
            bbox = step(self.detector, image);
            img = insertShape(image, 'Rectangle', bbox, 'Color', 'green', 'LineWidth', 2);
            new_img = insertShape(img, 'Rectangle', self.target, 'Color', 'blue', 'LineWidth', 2); 
        end
        
    end
end