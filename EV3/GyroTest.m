%fprintf("Current Angle: %d\n", brick.GyroAngle(2));
%pause(0.1);
brick.SetMode(2,Device.GyroCalib);
% for n = 1:3
%     brick.SetMode(2,Device.GyroCalib);
%     %fprintf("Gyro Calibrating...");
%     pause(0.1);
%     brick.SetMode(2,Device.GyroAng);
%     pause(0.1);
% end
% for i=1:20
%     fprintf("Angle: %d\n", brick.GyroAngle(2));
%     pause(0.1);
% end
