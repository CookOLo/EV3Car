global key;
InitKeyboard(); % Initializaes Keyboard prompting

remote = false;
auto = true;

previousColor = -1; 

while true

%Remote Control
while remote == true
    pause(0.1);

    switch key
        case 'p' % Move Picker Up
            disp('Up Arrow Pressed!');
            brick.MoveMotorAngleAbs('B', -3, 0, 'Brake'); 
            pause(0.1);
        
        case 'l' % Move Picker Down
            disp('Down Arrow Pressed!');
            brick.MoveMotorAngleAbs('B', 3, 0, 'Brake'); 
            pause(0.1);

        case 'leftarrow' % Stop Picker
            disp('Left Arrow Pressed!');
            brick.MoveMotor('B', 0); 
            brick.StopAllMotors('Brake');

        case 'w' % Forward
            brick.MoveMotor('A', -30);  
            brick.MoveMotor('D', -30);  

        case 's' % Reverse
            brick.MoveMotor('A', 30);  
            brick.MoveMotor('D', 30);  
        
        case 'a' % Left Turn
            brick.MoveMotor('A', 30);   
            brick.MoveMotor('D', -50);  
        
        case 'd' % Right Turn
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D', 30);  

        case 'space' % Stop Movement
            brick.MoveMotor('A', 0);  
            brick.MoveMotor('D', 0);  
        
        case 'q' %Switches to Auto
            remote = false;
            auto = true;
            disp('Q Pressed');
        
        case 0
            %disp('No Key Pressed!');
        
        
    end
end

%Auto Movement

while auto == true
    touch1324 = brick.TouchPressed(1);  % Reads touch sensor status
    distance = brick.UltrasonicDist(4); % Reads distance

    
    switch key % Switches back to remote
        case 'space' %Stops EV3 Car
            brick.MoveMotor('A', 0); 
            brick.MoveMotor('D', 0);  
    end
    

    if touch1324
        % Obstacle detected - reverse and turn to avoid it
        disp("Obstacle detected! Reversing and turning.");

        % Step 1: Reverse for a short distance
        brick.MoveMotor('A', 50);  % Reverse motor A
        brick.MoveMotor('D', 50);  % Reverse motor D
        pause(.8);                 % Reverse for 1.8 seconds
        brick.MoveMotor('A', 0);
        brick.MoveMotor('D', 0);
        pause(.8);

        %Left Turn Code
        if distance > 45
            brick.MoveMotor('A', 40);   % Left motor moves backward
            brick.MoveMotor('D', -40);  % Right motor moves forward
            
            pause(.9);                 % Pause to complete a 90-degree turn
            brick.MoveMotor('A', 0);
            brick.MoveMotor('D', 0);  % Stop all motors after turning

        %Right Turn Code
        else
            brick.MoveMotor('A', -40); % Left motor moves forward
            brick.MoveMotor('D', 40);  % Right motor moves backward
            pause(.9);                 % Pause to complete a 90-degree turn
            brick.MoveMotor('A', 0);
            brick.MoveMotor('D', 0);  % Stop all motors after turning
        end
        
        % Step 3: Resume forward movement
        disp("Resuming forward movement.");

    else
        % No obstacle detected - continue moving forward
        brick.MoveMotor('A', -50);  % Forward motor A
        brick.MoveMotor('D', -50);  % Forward motor D
    end
        

    

    % Short delay before next sensor check
    pause(0.1);  % Prevents continuous loop overload

    brick.SetColorMode(3, 2);
    color = brick.ColorCode(3);
    disp(color);
    
    if (color ~= previousColor) && (~isnan(color))
    %Testing with beeps
        brick.MoveMotor('A', 0);  
        brick.MoveMotor('D', 0);
        if color == 5  % If red is found
           
            brick.beep();
        end
    
        if color == 2  % If blue is found
            for i = 1:2 
                brick.beep();
                pause(.5); 
            end
            remote = true; % Changes to remote control
            auto = false;
        end

        if color == 3  % If green is found
            for i = 1:3
                brick.beep();
                pause(.5); 
            end
        end

        if color == 4  % If yellow is found
            for i = 1:4
                brick.beep();
                pause(.5); 
            end
            remote = true; % Changes to remote control
            auto = false;
        end
        brick.MoveMotor('A', 0); % Forward motor A
        brick.MoveMotor('D', 0); % Forward motor D
        pause(1);
    end

    previousColor = color; % Assigns current color as previous color

end
end

CloseKeyboard();