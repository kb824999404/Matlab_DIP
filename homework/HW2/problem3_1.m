clc,clear;
% Read the image
file_name='./Data/problem1_ganssConv_size9_sigma1.5.jpg';
I=imread(file_name);
imshow(I);

%Laplacian Filter
w=[0 -1 0;-1 5 -1;0 -1 0];
g=imfilter(I,w,'replicate');
figure,imshow(g);
imwrite(g,'Result/problem3_1/LaplacianFilter.jpg');
