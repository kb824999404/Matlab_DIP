img='resources/2.jpeg';
I = imread(img);
subplot(2,1,1);imshow(I);title('Original Image'); 
H = fspecial('average', [20,20]); 
IBlured = imfilter(I,H);
subplot(2,1,2);imshow(IBlured);title('Blurred Image');
