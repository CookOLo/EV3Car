% RGB Color Test

%brick = ConnectBrick('TacoBrick');

brick.SetColorMode(1,4);
pause(0.1);

for i=1:20
    color_rgb = brick.ColorRGB(1);
    fprintf("Sample %d\n", i);
    fprintf("\tRed: %d\n", color_rgb(1));
    fprintf("\tGreen: %d\n", color_rgb(2));
    fprintf("\tBlue: %d\n", color_rgb(3));
    pause(1);
end