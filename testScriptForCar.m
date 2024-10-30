% Connections and Disconnects
%clear all;
clear
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
while true
    % Check the touch sensor
    touch = brick.TouchPressed(1);  % Reads touch sensor status
    distance = brick.UltrasonicDist(4);

    if touch

        % Obstacle detected - reverse and turn to avoid it
        disp("Obstacle detected! Reversing and turning.");

        % Step 1: Reverse for a short distance
        brick.MoveMotor('A', 80);  % Reverse motor A
        brick.MoveMotor('D', 97);  % Reverse motor D
        pause(.9);                % Reverse for 1.8 seconds
        brick.StopAllMotors('Brake');  % Stop all motors
        
        
        if distance > 45
            brick.MoveMotor('D', -908);  % Left motor moves backward
            brick.MoveMotor('A', 95);   % Right motor moves forward
            pause(1.85);                 % Pause to complete a 90-degree turn
            brick.StopAllMotors('Brake');  % Stop all motors after turning
        else
            brick.MoveMotor('D', 95);  % Left motor moves backward
            brick.MoveMotor('A', -908);   % Right motor moves forward
            pause(1.85);                 % Pause to complete a 90-degree turn
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
end


 



