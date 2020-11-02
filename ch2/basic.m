img='resources/1.jpg';
f=imread(img);
whos f;
imshow(f);
imwrite(f,'resources/1.png');
K=imfinfo(img);
image_bytes=K.Width*K.Height*K.BitDepth/8;
compressed_bytes=K.FileSize;
compress_ratio=image_bytes/compressed_bytes;
compress_ratio
