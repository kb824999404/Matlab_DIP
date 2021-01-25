T = 0.001;
t=0:T:1;
fc = 100;
x = sin(2*pi*fc*t);
[X f] = FTviaFFT(x, T);
absX = abs(X);
figure(1)
clf
set(gcf, 'color', 'white')
subplot(211)
plot(t, x)
xlabel('t')
ylabel('x(t)')
subplot(212)
plot(f, absX.^2)
axis([-2*fc 2*fc 0 max(absX)^2])
xlabel('f')
ylabel('|X(f)|^2')