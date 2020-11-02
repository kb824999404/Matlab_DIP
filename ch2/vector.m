M=10,A=1;
for x=1:M   %Array indices in MATLAB cannot be 0
    f(x) = A*sin((x-1)/(2*pi));
end
f
x=0:M-1;
g=A*sin(x/(2*pi));
g