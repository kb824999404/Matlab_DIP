% 1D Gaussian filter
% sigma is the standard deviation of Gaussian function
% n is the window size
function w=gauss(sigma,n)
odd=mod(n,2);
k=(n-1)/2;
w=[0:n-1]-k;
w=exp(-power(w,2)./(2*power(sigma,2)));
sum_w=sum(w);
w=w./sum_w;
end