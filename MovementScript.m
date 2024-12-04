global key;
InitKeyboard(); % Initializaes Keyboard prompting

remote = false; % Sets up Remote/Auto Switches
auto = true;

previousColor = -1; % Sets up Previous Color Check

turnLeft = true; % Sets up TurnLeft Check -- for pickup

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
    
        brick.SetColorMode(3, 2); % Sets Up Color Mode for Color Sensor to Read Color
        color = brick.ColorCode(3); % Reads Color
        disp(color);
    
        switch key % Switches back to remote
            case 'space' %Stops EV3 Car
                brick.MoveMotor('A', 0); 
                brick.MoveMotor('D', 0); 
            case '0' % Continues EV3 Car
                brick.MoveMotor('A', -50); 
                brick.MoveMotor('D', -50);
            case 'r' % Force to Remote Control
                remote = true;
                auto = false;
        end
    
        if (distance > 40) && (turnLeft == true) % Hard-Coded Left Turn
    
                pause(.3);
                brick.MoveMotor('A', 40);   % Left motor moves backward
                brick.MoveMotor('D', -40);  % Right motor moves forward
                
                pause(.9);                 % Pause to complete a 90-degree turn
                brick.MoveMotor('A', 0);
                brick.MoveMotor('D', 0);  % Stop all motors after turning
                brick.MoveMotor('A', -50);  % Forward motor A
                brick.MoveMotor('D', -50);  % Forward motor D
                pause(.5);
                turnLeft = false;
                disp("Doing hard-coded left turn.");
                disp("Distance: " + distance);
        end
        
    
        if touch1324 % If touch, reverse and turn
            disp("Obstacle detected! Reversing and turning.");
            disp("Distance: " + distance);
            % Step 1: Reverse for a short distance
            brick.MoveMotor('A', 50);  % Reverse motor A
            brick.MoveMotor('D', 50);  % Reverse motor D
            pause(0.8);                 % Reverse for 1.8 seconds
            brick.MoveMotor('A', 0);
            brick.MoveMotor('D', 0);
            pause(0.8);
    
            % Left Turn if distance if far enough
            if distance > 45
                brick.MoveMotor('A', 40);   % Left motor moves backward
                brick.MoveMotor('D', -40);  % Right motor moves forward
                
                pause(.9);                 % Pause to complete a 90-degree turn
                brick.MoveMotor('A', 0);
                brick.MoveMotor('D', 0);  % Stop all motors after turning
    
            % Right Turn
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
            brick.MoveMotor('A', -50);  % Forward motor A
            brick.MoveMotor('D', -50);  % Forward motor D
        end
                
    
        % Short delay before next sensor check
        pause(0.1);  % Prevents continuous loop overload
    
        
        
        if (color ~= previousColor) && (~isnan(color))
        %Testing with beeps
            if color == 5  % If red is found
                brick.MoveMotor('A', 0);  
                brick.MoveMotor('D', 0);
                brick.beep();
            end
        
            if color == 2  % If blue is found
                pause(.2);
                brick.MoveMotor('A', 0);  
                brick.MoveMotor('D', 0);
                for i = 1:2   
                    brick.beep();
                    pause(.5); 
                end
                remote = true; % Changes to remote control
                auto = false;
            end
    
            if color == 3  % If green is found
                pause(.5);
                brick.MoveMotor('A', 0);  
                brick.MoveMotor('D', 0);
                for i = 1:3
                    brick.beep();
                    pause(.5); 
                end
                auto = false;
                break;
                
            end
    
            if color == 4  % If yellow is found
                pause(1);
                brick.MoveMotor('A', 0);  
                brick.MoveMotor('D', 0);
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