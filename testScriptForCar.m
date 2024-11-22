%Connections and Disconnects
%clear all;
%clear
brick = ConnectBrick('G11');
color = brick.ColorCode(1); % Get Color on port 1.

display(color); % Print color code of the object.

%Remote Control

remote = true;
auto = false

global key;


InitKeyboard();

while remote == true
    pause(0.1);

    switch key
        case 'uparrow'
            disp('Up Arrow Pressed!');
            brick.MoveMotorAngleAbs('B', -1, 0, 'Brake'); % Move Picker Up
            brick.WaitForMotor('B');
            pause(0.01);
        
        case 'downarrow'
            disp('Down Arrow Pressed!');
            brick.MoveMotorAngleAbs('B', 1, 0, 'Brake'); % Move Picker Down
            brick.WaitForMotor('B');
            pause(0.01);

        case 'leftarrow'
            disp('Left Arrow Pressed!');
            brick.MoveMotor('B', 0); % Stop Picker
            brick.StopAllMotors('Brake');

        case 'w'
            brick.MoveMotor('A', -30);  % Forward motor A
            brick.MoveMotor('D', -30);  % Forward motor D

        case 's'
            brick.MoveMotor('A', 30);  % Reverse motor A
            brick.MoveMotor('D', 30);  % Reverse motor D
        
        case 'a'
            brick.MoveMotor('A', 30);   % Left motor moves backward
            brick.MoveMotor('D', -50);  % Right motor moves forward
        
        case 'd'
            brick.MoveMotor('A', -50);% Left motor moves forward
            brick.MoveMotor('D', 30);  % Right motor moves backward

        case 'space'
            brick.MoveMotor('A', 0);  % Stop motor A
            brick.MoveMotor('D', 0);  % Stop motor D
        
        case 'q'                      %Switches to Auto
            remove = false;
            auto = true;
        
        case 0
            disp('No Key Pressed!');
        
        
    end
end




%Auto Movement

previousColor = -1; 


while auto == true
    % Check the touch sensor
    touch = brick.TouchPressed(1);  % Reads touch sensor status
    distance = brick.UltrasonicDist(4);

    
    switch key                      % Switches back to remote
        case 'q'
           remove = true;
           auto = false; 

        case 'space'                %Stops EV3 Car
            brick.MoveMotor('A', 0);  % Stop motor A
            brick.MoveMotor('D', 0);  % Stop motor D
    end
    
    if touch

        % Obstacle detected - reverse and turn to avoid it
        disp("Obstacle detected! Reversing and turning.");

        % Step 1: Reverse for a short distance
        brick.MoveMotor('A', 50);  % Reverse motor A
        brick.MoveMotor('D', 50);  % Reverse motor D
        pause(.5);                % Reverse for 1.8 seconds
        brick.StopAllMotors('Brake');  % Stop all motors
        pause(.5);  
        brick.MoveMotor('A', 40);   % Left motor moves backward
        brick.MoveMotor('D', -40);  % Right motor moves forward
            
        pause(.8);                 % Pause to complete a 90-degree turn
        brick.StopAllMotors('Brake');  % Stop all motors after turning
        
        %%
        
        %Left Turn Code
        %{
        if distance > 45
            brick.MoveMotor('A', 100);   % Left motor moves backward
            brick.MoveMotor('D', -9999999999999);  % Right motor moves forward
            
            pause(1.5);                 % Pause to complete a 90-degree turn
            brick.StopAllMotors('Brake');  % Stop all motors after turning
        %Right Turn Code
        else
            brick.MoveMotor('A', -9999999999999);% Left motor moves forward
            brick.MoveMotor('D', 100);  % Right motor moves backward
            pause(1.5);                 % Pause to complete a 90-degree turn
            brick.StopAllMotors('Brake');  % Stop all motors after turning
        end
        
        % Step 3: Resume forward movement
        disp("Resuming forward movement.");
%}
    else
        % No obstacle detected - continue moving forward
        brick.MoveMotor('A', -50);  % Forward motor A
        brick.MoveMotor('D', -50);  % Forward motor D
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
        brick.MoveMotor('A', 0);  % Forward motor A
        brick.MoveMotor('D', 0);
        %brick.StopAllMotors('Brake');
        pause(1);
    end
    previousColor = color;
end

CloseKeyboard();