function [X f] = FTviaFFT(x, T, N)
if nargin<3
 N = length(x);
elseif length(x)<N %N=2^n
 x(N)=0;%²¹Áã
end
X = fft(x, N);
X=T*fftshift(X);
f = 1/T/N*(-N/2:N/2-1);
return
