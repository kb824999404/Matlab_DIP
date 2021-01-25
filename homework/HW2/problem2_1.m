clc,clear;
% Read the image
file_name='./Data/p2d1';
I=readImage(file_name,600);
imwrite(I,'Result/problem2_1/OriginalImage.jpg');
% imshow(I);

% window size
ns=[1 3 5 7];

% min filter
for n=ns
    g=minFilter(I,n);
    figure,imshow(g);
    file_name=char(sprintf("Result/problem2_1/minfilter_%d.jpg",n));
    imwrite(g,file_name);
end


