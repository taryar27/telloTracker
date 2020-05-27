%% Tracker Class

classdef Tracker < handle
    properties (SetAccess = private)
        target = [537,151;763,151;537,377;763,377]; % Target points for the bounding box approx 80cm.
        lambda = 0.1; % Gain value for visual servoing velocity controller
        p = 480; % principal point px at the centre of drone image
        f = 910; % focal point of drone camera from calibrated results
    end
    
    methods
        % function to set the target to track
        function setTarget(self, target)
            self.target = target;
        end

        % function to get velocity from to track the target
        function vc = getVelocity(self, bbox)
            % The following algorithm calculates the value of Z 
            % 30cm = 476
            % 40cm = 334
            % 50cm = 282
            % 60cm = 250
            % 100cm = 168
            Z = 39606 * power(bbox(4), -1.176);
            
            % The following algorithm calculates control velocity to move
            % the observed image to the target
            obs = [bbox(1),bbox(2);bbox(1)+bbox(3),bbox(2);
                bbox(1),bbox(2)+bbox(4);bbox(1)+bbox(3),bbox(2)+bbox(4)];
            
            Obsxy = (obs-self.p)/self.f;
            xy = (self.target-self.p)/self.f;
            
            n = length(self.target(:,1));

            Lx = [];
            for i=1:n
                Lxi = self.getLx(xy(i,1),xy(i,2),Z);
                Lx = [Lx;Lxi];
            end

            e2 = Obsxy-xy;
            e = reshape(e2',[],1);

            Lx2 = inv(Lx'*Lx)*Lx';
            vc = -self.lambda*Lx2*e;
        end
        
        % function to get image jacobian from x,y and Z camera points
        function [Lx] = getLx(self,x,y,Z)

            Lx = zeros(2,6);

            Lx(1,1) = -1/Z;
            Lx(1,2) = 0;
            Lx(1,3) = x/Z;
            Lx(1,4) = x*y;
            Lx(1,5) = -(1+x^2);
            Lx(1,6) = y;

            Lx(2,1) = 0;
            Lx(2,2) = -1/Z;
            Lx(2,3) = y/Z;
            Lx(2,4) = 1+y^2;
            Lx(2,5) = -x*y;
            Lx(2,6) = -x;
        end
    end
end