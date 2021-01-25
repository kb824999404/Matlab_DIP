clc,clear;
% Read the image
file_name='./Data/p2d3';
I=readImage(file_name,600);
imwrite(I,'Result/problem2_3/OriginalImage.jpg');
% imshow(I);


% window size
ns=[1 3 5 7];

% median filter
for n=ns
    g=ordfilt2(I,median([1,n*n]),ones(n,n));
    figure,imshow(g);
    file_name=char(sprintf("Result/problem2_3/medianfilter_%d.jpg",n));
    imwrite(g,file_name);
end


