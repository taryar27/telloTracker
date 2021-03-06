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
        vx = 0.4; % default speed of the drone
        vy = 0.4;
        vz = 0.4;
        wait = true; % default drone mode. True = drone waits until movement is finished.
        target = [380 260 200 200];% target bounding box for the drone
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
        
        function target = getTarget(self)
            target = self.target;
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
        
        
        % For translational movements.
        % translation: movement in 3D space. Must be specified in [x y z]
        % displacement.
        % speed: speed of the drone for the specified movement in xyz directions. default is
        % 0.4 m/s.
        % wait: boolean value. true = matlab code is blocked until drone
        % completes movement. false = non-blocking mode.
        % Speed and Wait values can be changed with the following setters.
        
        function setSpeed(self, vx, vy, vz)
            self.vx = vx;
            self.vy = vy;
            self.vz = vz;
        end
        
        function setMode(self, wait)
            self.wait = wait;
        end
        
        % translation distance has to be between 0.2 and 5 metres
        function transl(self, translation)
            if translation(1) < -0.2
                self.drone.moveback('Distance',abs(translation(1)),'Speed',self.vx,'WaitUntilDone',self.wait);
            elseif translation(1) > 0.2
                self.drone.moveforward('Distance',abs(translation(1)),'Speed',self.vx,'WaitUntilDone',self.wait);
            else
            end
            
            if translation(2) < -0.2
                self.drone.moveleft('Distance',abs(translation(2)),'Speed',self.vy,'WaitUntilDone',self.wait);
            elseif translation(2) > 0.2
                self.drone.moveright('Distance',abs(translation(2)),'Speed',self.vy,'WaitUntilDone',self.wait);
            else
            end
            
            if translation(3) < -0.2
                self.drone.moveup('Distance',abs(translation(3)),'Speed',self.vz,'WaitUntilDone',self.wait);
            elseif translation(3) > 0.2
                self.drone.movedown('Distance',abs(translation(3)),'Speed',self.vz,'WaitUntilDone',self.wait);
            else
            end
        end
        
        % rotation in wx direction. The angle is specified in degrees
        function rotate(self, angle)
            self.drone.turn(deg2rad(angle));
        end
        
    end
end