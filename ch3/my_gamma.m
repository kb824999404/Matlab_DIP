% gamma transformation
% I is the input image
function out = my_gamma(I,a,y)
out=a*(double(I).^y);
out=uint8(out);
