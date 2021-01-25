clear,clc;
img='resources/xinhaicheng.png';
f=imread(img);
F=fft2(f(:,:,1));
F=fftshift(F);
F=abs(F);
F=log(F+1);
imshow(F,[]);