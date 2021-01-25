T = 0.001;
t=-10:T:10;
tau = 1;
x = t<=tau/2 &t>=-tau/2;
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
plot(f, tau^2*sinc(f*tau).^2, 'b-')
hold on;
plot(f, absX.^2, 'r.')
axis([-10/tau 10/tau 0 max(absX)^2])
xlabel('f')
ylabel('|X(f)|^2')
legend('Exact FT','Numerical FT')
