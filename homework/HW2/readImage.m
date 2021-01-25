% read image from binary file
% fileName is the name of the binary file
% rowSize is the byte size of each line
function I=readImage(fileName,rowSize)
file=fopen(fileName,'r');
A=fread(file,[rowSize inf]);
fclose(file);
I=uint8(A);
end