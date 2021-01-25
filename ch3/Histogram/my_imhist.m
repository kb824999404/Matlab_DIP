% Calculate the histogram of an image
% I is the image
function [h]=my_imhist(I)
h=zeros(256,1);
[X,Y]=size(I);
for i=1:X
    for j=1:Y
        index = I(i,j)+1;
        if index>=1&&index<=256
            h(index,1)=h(index,1)+1;
        end
    end
end

        