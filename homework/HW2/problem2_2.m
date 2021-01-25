clc,clear;
% Read the image
file_name='./Data/p2d2';
I=readImage(file_name,600);
imwrite(I,'Result/problem2_2/OriginalImage.jpg');
% imshow(I);


% window size
ns=[1 3 5 7];

% max filter
for n=ns
    g=maxFilter(I,n);
    figure,imshow(g);
    file_name=char(sprintf("Result/problem2_2/maxfilter_%d.jpg",n));
    imwrite(g,file_name);
end


