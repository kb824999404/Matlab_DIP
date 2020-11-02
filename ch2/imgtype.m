img='resources/1.jpg';
f=imread(img);
g=mat2gray(f);     %归一化
gb=im2bw(g,0.5);    %二值图像
figure;
imshowpair(f,gb,'montage');

