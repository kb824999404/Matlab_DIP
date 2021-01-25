% applies Gaussian convolution to a 2D image
% image is the source image
% sigma is the standard deviation of Gaussian function
% n is the window size of Gaussian filter
function out=gaussConv(image,sigma,n)
w=gauss2d(sigma,n);
out=conv2(image,w,'same');
out=uint8(out);
end