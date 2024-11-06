% Connections and Disconnects
%clear all;
%clear
brick = ConnectBrick('G11');
%brick = DisconnectBrick('G11');
%clear 'G11'

%References
%{
%MOVE FORWARD
%brick.MoveMotor('A', 50); % Motor A forward at half speed.

%REVERSE AND TURN
%brick.MoveMotorAngleRel('A', 20, -90, 'Brake');

%STOP A SPECIFIC MOTOR
%brick.StopMotor(MotorPort, BrakeType);

%STOP ALL MOTORS
%brick.StopAllMotors(BrakeType);

%TOUCH SENSOR
%reading = brick.TouchPressed(SensorPort);

%ULTRASONIC SENSOR
%distance = brick.UltrasonicDist(SensorPort);

%COLOR
%brick.SetColorMode(1, 2); % Set Color Sensor connected to Port 1 to Color Code Mode

color = brick.ColorCode(1); % Get Color on port 1.

display(color); % Print color code of the object.

%}

%Movement by Control
%{
while 1
     key = input('Press a key (type "q" to quit): ', 's');
     
     %move reverse
     if strcmp(key, 's')
        brick.MoveMotor('A', 60);
        brick.MoveMotor('D', 70);
     %turn right
     elseif strcmp(key, 'd')
        brick.MoveMotor('A', -90);
        brick.MoveMotor('D', -30);
     %turnleft
     elseif strcmp(key, 'a')
        brick.MoveMotor('A', -30);
        brick.MoveMotor('D', -90);
     %move forward
     elseif strcmp(key, 'w')
        brick.MoveMotor('A', -73);
        brick.MoveMotor('D', -60);
     %using pickup
     elseif strcmp(key, 'e')
         brick.MoveMotor('B', -10);
         %pause(2);
     %brake
     elseif strcmp(key, 'o')
         brick.MoveMotor('B', 0);
     elseif strcmp(key, 'r')
         brick.MoveMotor('B', 50);
     else
         brick.StopMotor('A', 'Coast');
         brick.StopMotor('D', 'Coast');
         break;
     end
end
%}



%Auto Movement

previousColor = -1; 

while true
    % Check the touch sensor
    touch = brick.TouchPressed(1);  % Reads touch sensor status
    distance = brick.UltrasonicDist(4);
    
    
    if touch

        % Obstacle detected - reverse and turn to avoid it
        disp("Obstacle detected! Reversing and turning.");

        % Step 1: Reverse for a short distance
        brick.MoveMotor('A', 120);  % Reverse motor A
        brick.MoveMotor('D', 50);  % Reverse motor D
        pause(1.2);                % Reverse for 1.8 seconds
        brick.StopAllMotors('Brake');  % Stop all motors
        
        
        if distance > 45
            brick.MoveMotor('D', -980);  % Left motor moves backward
            brick.MoveMotor('A', 80);   % Right motor moves forward
            pause(1.7);                 % Pause to complete a 90-degree turn
            brick.StopAllMotors('Brake');  % Stop all motors after turning
        else
            brick.MoveMotor('D', 80);  % Left motor moves backward
            brick.MoveMotor('A', -980);   % Right motor moves forward
            pause(1.7);                 % Pause to complete a 90-degree turn
            brick.StopAllMotors('Brake');  % Stop all motors after turning
        end
        
        % Step 3: Resume forward movement
        disp("Resuming forward movement.");
    else
        % No obstacle detected - continue moving forward
        brick.MoveMotor('A', -60);  % Forward motor A
        brick.MoveMotor('D', -72);  % Forward motor D
    end

    

    % Short delay before next sensor check
    pause(0.1);  % Prevents continuous loop overload

    brick.SetColorMode(2, 2);
    color = brick.ColorCode(2);
    disp(color);
    
    if color ~= previousColor
    %Testing with beeps
        brick.StopAllMotors('Brake');
        if color == 5  % If red is found
                brick.beep();
                pause(1);
            
        end
    
        if color == 2  % If blue is found
            for i = 1:2 
                brick.beep();
                pause(.5); % Small pause between beeps
            end
        end

        if color == 3  %If green is found
            for i = 1:3
                brick.beep();
                pause(.5); % Small pause between beeps
            end
        end

        if color == 4  % If yellow is found
            for i = 1:4
                brick.beep();
                pause(.5); % Small pause between beeps
            end
        end
        brick.StopAllMotors('Brake');
        pause(1);
    end
    previousColor = color;
end


%Color Sensor Test
%{
while true
    brick.SetColorMode(2, 2);
    color = brick.ColorCode(2);
    disp(color);
    
    if color ~= previousColor
    %Testing with beeps
    if color == 5  % If red is found
        brick.StopAllMotors('Brake');
        brick.beep();
        pause(1);
        brick.StopAllMotors('Brake');
    end
    
    if color == 2  % If blue is found
        brick.StopAllMotors('Brake');
        for i = 1:2
            brick.beep();
            pause(1); % Small pause between beeps
        end
        brick.StopAllMotors('Brake');
    end

    if color == 3  %If green is found
        brick.StopAllMotors('Brake');
        for i = 1:3
            brick.beep();
            pause(1); % Small pause between beeps
        end
        brick.StopAllMotors('Brake');
    end

    if color == 4  % If yellow is found
        brick.StopAllMotors('Brake');
        for i = 1:4
            brick.beep();
            pause(1); % Small pause between beeps
        end
        brick.StopAllMotors('Brake');
    end
    end
    previousColor = color;
end
%}
