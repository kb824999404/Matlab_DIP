img='resources/1.jpg';
f=imread(img);
g=mat2gray(f);     %��һ��
gb=im2bw(g,0.5);    %��ֵͼ��
figure;
imshowpair(f,gb,'montage');

