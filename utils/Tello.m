%% Tello Class
% Class for interfacing between a DJI (Ryze) Tello drone and MATLAB
% This class requires MATLAB R2020a and above. 
% MATLAB support package for Ryze Tello Drones is also required.
% Before calling this class, Tello drone must be switched on, and the
% device must be connected to Tello wifi network.

classdef Tello < handle
    properties (SetAccess = private)
        drone; % drone object created at class initialisation
        camera; % flight camera mounted on the drone
    end
    
    methods
        % Constructor for building a Tello object
        % The name of the drone can be specified. Else default name will be
        % used.
        function self = Tello(droneName)
            if nargin == 1
                self.drone = ryze(droneName);
            else
                self.drone = ryze();
            end
            self.camera = camera(self.drone);
        end
        
        % Returns current state of the drone. Landing, Hovering etc.
        function droneState = getState(self)
            droneState = self.drone.State;
        end
        
        function droneBattery = getBattery(self)
            droneBattery = self.drone.BatteryLevel;
        end
        
        % Returns relative height of the drone
        function droneHeight = getHeight(self)
            [droneHeight, ~] = self.drone.readHeight();
        end
        
        % Returns orientation of the drone in eular angles
        function droneOrientation = getOrientation(self)
            [droneOrientation, ~] = self.drone.readOrientation();
        end
        
        function droneSpeed = getSpeed(self)
            [droneSpeed, ~] = self.drone.readSpeed();
        end
        
        function droneCameraResolution = getResolution(self)
            droneCameraResolution = self.camera.Resolution;
        end
        
        % method to take an image from drone camera
        function frame = snapshot(self)
            frame = self.camera.snapshot();
        end
        
        % method to stream live video feed from the drone
        function preview(self)
            self.camera.preview();
        end
        
        function closePreview(self)
            self.camera.closePreview();
        end
        
        function takeoff(self)
            self.drone.takeoff();
        end
        
        function land(self)
            self.drone.land();
        end
        
        % method to end current drone mission
        function abort(self)
            self.drone.abort();
        end
        
        % For translational movements.
        % translation: movement in 3D space. Must be specified in [x y z]
        % displacement.
        % speed: speed of the drone for the specified movement. default is
        % 0.4 m/s.
        % wait: boolean value. true = matlab code is blocked until drone
        % completes movement. false = non-blocking mode.
        function transl(self, translation, speed, wait)
            switch nargin
                case 1
                    self.drone.move(translation);
                case 2
                    self.drone.move(translation, 'Speed', speed);
                case 3
                    self.drone.move(translation, 'Speed', speed, 'WaitUntilDone', wait);
            end
        end
        
        % rotation in wx direction. The angle is specified in degrees
        function rotate(self, angle)
            self.drone.turn(deg2rad(angle));
        end
        
    end
end