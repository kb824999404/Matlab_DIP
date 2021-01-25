% 2D Gaussian filter
% sigma is the standard deviation of Gaussian function
% n is the window size
function w=gauss2d(sigma,n)
w1=gauss(sigma,n);
w2=w1';
w=conv2(w1,w2);
end