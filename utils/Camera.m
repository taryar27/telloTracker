%% Camera Class
% Class to connect (USB) webcams to MATLAB for interfacing.
% This class requires MATLAB support package for USB Webcams.
% USB webcams or build in webcams can be used.
% Before calling the class, use 'webcamlist' to find out which webcams are
% currently available. 

classdef Camera < handle
    properties (SetAccess = private)
        camera; % webcam object
    end
    
    methods
        % Use 'webcamlist' to find out the number of camera available and
        % create Camera object using the respective indices. Default is 1.
        function self = Camera(id)
            if nargin == 0
                self.camera = webcam();
            else
                self.camera = webcam(id);
            end
        end
        
        % Returns camera resolution in a string
        function resolution = getResolution(self)
            resolution = self.camera.Resolution();
        end
        
        % Function to live stream video from webcam
        function preview(self)
            self.camera.preview();
        end
        
        % Returns an image from the webcam
        function frame = snapshot(self)
            frame = self.camera.snapshot();
        end
    end
end