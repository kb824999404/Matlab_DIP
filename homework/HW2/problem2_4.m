clc,clear;
% Read the image
I1=readImage('./Data/p2d1',600);
I2=readImage('./Data/p2d2',600);

n=3;
%apply max filter to I1
g1=maxFilter(I1,n);
figure,imshow(g1);
imwrite(g1,char("Result/problem2_4/I1_maxfilter.jpg"));

%apply min filter to I2
g2=minFilter(I2,n);
figure,imshow(g2);
imwrite(g2,char("Result/problem2_4/I2_minfilter.jpg"));





