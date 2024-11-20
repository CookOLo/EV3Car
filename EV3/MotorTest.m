brick.ResetMotorAngle('A');
RelError = 0;
angle = 0;

for i=1:10
    brick.MoveMotorAngleRel('A', 100, 90, 'Brake');
    brick.WaitForMotor('A');
    angle = brick.GetMotorAngle('A');
    RelError = RelError + abs(90-angle);
    brick.ResetMotorAngle('A');
end
display('Relative Error:');
disp(RelError/10);

brick.ResetMotorAngle('A');
AbsError = 0;

for i=1:10
    brick.MoveMotorAngleAbs('A', 100, 90, 'Brake');
    brick.WaitForMotor('A');
    brick.MoveMotorAngleAbs('A', 100, 0, 'Brake');
    brick.WaitForMotor('A');
    AbsError = AbsError + brick.GetMotorAngle('A');
    brick.ResetMotorAngle('A');
end
display('Absolute Error:');
disp(AbsError/10);