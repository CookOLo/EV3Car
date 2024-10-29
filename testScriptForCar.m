% Connections and Disconnects
%clear all;
%brick = ConnectBrick('G11');
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
i = 0;
while i == 0
    %distance = brick.UltrasonicDist(4);
    %key = input('Press a key (type "q" to quit): ', 's');
    touch = brick.TouchPressed(1);
    stopped = false;
    
    %{
    while ~touch
        brick.MoveMotor('A', -60);
        brick.MoveMotor('D', -72);
    end
    %}

    if touch
        %Reverses the brick then makes 90 degree angle
        disp("test");
        brick.MoveMotor('A', 80);
        brick.MoveMotor('D', 92);

        %Waits until brick motion is completed
        pause(1.8);
        brick.MoveMotor('D', -98);
        brick.MoveMotor('A', 0);
        pause(3.1);
        brick.StopMotor('A');
        brick.StopMotor('D');
    else 
        brick.MoveMotor('A', -60);
        brick.MoveMotor('D', -72);
        %brick.MoveMotor('A', 0);
        %brick.MoveMotor('D', 0);
    %Shortcut for ending operation
    
    %elseif strcmp(key, 'q')
    %    brick.StopMotor('A', 'Brake');
    %    brick.StopMotor('D', 'Brake');
    %    break;
    
    %Moves forward if nothing touches touch sensor
    
    end
     
    %Test for ultrasonic sensor
    %{
    if distance < 3
        brick.MoveMotor('A', -60);
        brick.MoveMotor('D', -72);
    end
    %}
end
  



