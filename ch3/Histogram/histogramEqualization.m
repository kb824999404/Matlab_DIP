img='resources/CT_1.jpg';
f=imread(img);
% Histogram Equalization
figure;
g=histeq(f);
subplot 221;
imshow(f);
subplot 222;
imshow(g);
subplot 223;
horz=1:256;
bar(horz,imhist(f));
subplot 224;
bar(horz,imhist(g));