clc,clear;
% Read the image
file_name='./Data/p3';
I=readImage(file_name,600);
imwrite(I,'Result/problem3_2/OriginalImage.jpg');
imshow(I);

%Laplacian Filter
w=[-1 -1 -1;-1 9 -1;-1 -1 -1];
g1=imfilter(I,w,'replicate');
figure,imshow(g1);
imwrite(g1,'Result/problem3_2/LaplacianFilter.jpg');

% Laplacian of Gaussian Filter
sigmas=[0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55];
for sigma=sigmas
    w_log=fspecial('log',[3 3],sigma);
    O=imfilter(I,w_log,'replicate');
    g2=I-O;
    figure,imshow(g2);
    file_name=char(sprintf("Result/problem3_2/LaplacianOfGaussianFilter_%.2f.jpg",sigma));
    imwrite(g2,file_name);
end

