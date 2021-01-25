clc,clear;
% Read the original image
file_name='./Data/p1';
I=readImage(file_name,600);
imwrite(I,'Result/problem1_1/originalImage.jpg');

% size of mask
ns=[1 3 5 7 9 11];


for n=ns
    % Filter2
    mask=fspecial('average',[n n]);
    g1=filter2(mask,I,'same');
    g1=uint8(g1);
    figure,imshow(g1);
    file_name=char(sprintf("Result/problem1_1/filter2_size%d.jpg",n));
    imwrite(g1,file_name);
    % Conv2
    g2=conv2(I,mask,'same');
    g2=uint8(g2);
    figure,imshow(g2);
    file_name=char(sprintf("Result/problem1_1/conv2_size%d.jpg",n));
    imwrite(g2,file_name);
end

