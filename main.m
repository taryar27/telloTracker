%% Tello Tracker

% The main script to run visual servoing from tello tracker project
% Currently only available from webcam. Drone camera update coming soon.

state = false; % boolean to toggle drone or not drone
locked = false; % boolean to lock target on drone

choice = input('(0 for Webcam, 1 for Drone): ');
if choice == 1
    state = true;
    c = Tello();
    p = ImageProcessor(c.getTarget);
    t = Tracker();
    t.setTarget(c.getTarget);
else
    state = false;
    c = Camera();
    p = ImageProcessor();
    t = Tracker();
end

% If drone is chosen, start up the drone
if state
    c.takeoff;
    c.transl([0 0 -0.5]);
    while ~locked
        c.rotate(5);
       i = c.snapshot;
        [img, bbox] = p.detect(i);
        if ~isempty(bbox)
            locked = true;
        end
    end
end

figure('Name', 'Face Tracker');
annotation('textarrow', [0.75 0.85], [0.75 0.75]);
annotation('textarrow', [0.75 0.75], [0.75 0.65]);
while true
    i = c.snapshot;
    [img, bbox] = p.detect(i);
    v = t.getVelocity(bbox);
    
    % coordinate system
    %  - - - - - - > x (+)
    % |
    % |
    % |
    % |
    % |
    % v
    % y (+)
    
    % z(+) towards the camera/object
    % z(-) away from the camera/object
    
    % text commands for velocity controls
    textv1 = sprintf('Vx: %.2f m/s',v(1));
    textv2 = sprintf('Vy: %.2f m/s',v(2));
    textv3 = sprintf('Vz: %.2f m/s',v(3));
    textv4 = sprintf('w: %.2f rad/s',v(4));
    img = insertText(img,[100 50],textv1,'FontSize',30,'BoxColor','red','BoxOpacity',0.4,'TextColor','white');
    img = insertText(img,[100 100],textv2,'FontSize',30,'BoxColor','green','BoxOpacity',0.4,'TextColor','white');
    img = insertText(img,[100 150],textv3,'FontSize',30,'BoxColor','blue','BoxOpacity',0.4,'TextColor','white');
    img = insertText(img,[100 200],textv4,'FontSize',30,'BoxColor','yellow','BoxOpacity',0.4,'TextColor','white');
    
    if v(1) < 0
        xStr = '2. move camera towards right -->';
    elseif v(1) > 0
        xStr = '2. move camera towards left <--';
    else
        xStr = '2. camera is horizontally aligned';
    end
    
    if v(2) > 0
        yStr = '3. move camera down v';
    elseif v(2) < 0
        yStr = '3. move camera up ^';
    else
        yStr = '3. camera is vertically aligned';
    end
    
    if v(3) > 0
        zStr = '1. move camera towards the object';
    elseif v(3) < 0
        zStr = '1. move camera away from the object';
    else
        zStr = '1. camera is at a good distance';
    end

    img = insertText(img,[100 500],zStr,'FontSize',20,'BoxColor','red','BoxOpacity',0.6,'TextColor','white');
    img = insertText(img,[100 550],xStr,'FontSize',20,'BoxColor','green','BoxOpacity',0.6,'TextColor','white');
    img = insertText(img,[100 600],yStr,'FontSize',20,'BoxColor','blue','BoxOpacity',0.6,'TextColor','white');
    
    % end of text clues on velocity control
    
    thres = 1.5; % threshold velocity to move the drone 
    % drone flight controls
    if state
        if v(3) > thres
            % moves the drone towards the object (+x)
            c.transl([0.25 0 0]);
        elseif v(3) < -thres
            % moves the drone away from the object (-x)
            c.transl([-0.25 0 0]);
        end
        
        if v(2) > thres
            % moves the drone down (+z)
            c.transl([0 0 0.25]);
        elseif v(2) < -thres
            % moves the drone up (-z)
            c.transl([0 0 -0.25]);
        end
        
        if v(1) > -thres
            % moves the drone left (+y)
            c.transl([0 0.25 0]);
        elseif v(1) < thres
            % moves the drone right (-y)
            c.transl([0 -0.25 0]);
        end
    end
    % end of drone flight controls
    
    
    image(img);
    axis equal;
    axis tight;
end