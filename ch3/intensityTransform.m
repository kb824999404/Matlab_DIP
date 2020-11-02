img='resources/xinhaicheng.png';
f=imread(img);
figure;
subplot(2,2,1);
imshow(f);
% Brightness Invert
g1=imadjust(f,[0 1],[1 0]);
subplot(2,2,2);
imshow(g1);
% g2=imcomplement(f);
% subplot(2,2,3);
% imshow(g2);
% Indensity Adjust
g3=imadjust(f,[0.5 0.75],[0 1]);
subplot(2,2,3);
imshow(g3);
% gamma transform
g4=imadjust(f,[],[],2);
subplot(2,2,4);
imshow(g4);

% log transform
g5=im2uint8(mat2gray(log(1+double(f))));
subplot(2,2,2);
imshow(g5);

g6=intrans(f,'stretch',mean2(im2double(f)),0.9);
figure,imshow(g6);
