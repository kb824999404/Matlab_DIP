% Histogram Equalization
% I is the input image
function [g]=my_histeq(I)
[X,Y]=size(I);
counts = my_imhist(I);  % the origin histogram
f_eq=zeros(1,256);    % the histogram equalization result

sum_count=0;
for i=1:256
    sum_count=sum_count+counts(i,1);
    f_eq(1,i)=round(sum_count*255/(X*Y));
end

g = f_eq(1,I+1);   % Transform indensity
g = uint8(reshape(g, [X, Y]));