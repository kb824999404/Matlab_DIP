clc,clear;
% Read the image
file_name='./Data/p1';
I=readImage(file_name,600);
% imshow(I);

% window size
ns=[3 5 7 9 11 13];
% sigma values
sigmas=[0.5 0.8 1.1 1.5 1.8 2.1];

for i=1:6
    n=ns(i);
    sigma=sigmas(i);
    %Gaussian Conv
    g1=gaussConv(I,sigma,n);
    figure,imshow(g1);
    file_name=char(sprintf("Result/problem1_2/ganssConv_size%d_sigma%.1f.jpg",n,sigma));
    imwrite(g1,file_name);

    %imfilter
    w=gauss2d(sigma,n);
    g2=imfilter(I,w,'conv');
    % figure,imshow(g2);
    file_name=char(sprintf("Result/problem1_2/imfilter_size%d_sigma%.1f.jpg",n,sigma));
    imwrite(g2,file_name);
end



