img='resources/xinhaicheng.png';
f=imread(img);
figure;
subplot 321;
imshow(f);
% Show Histogram Diagram
h = imhist(f,256);
p = h/numel(f);
horz=1:256;
subplot 322;
bar(horz,h);
subplot 323;
bar(horz,p);
subplot 324;
h1 = h(1:10:256);
horz = 1:10:256;
bar(horz,h1);
subplot 325;
stem(horz,h1,'fill');
subplot 326;
plot(horz,h1,'color','b');


