% max Filter
% img is the source image
% n is the window size
function out=maxFilter(img,n)
padSize = floor(n/2);
tempOut = padarray(img,[padSize  padSize],'symmetric');
[M N]=size(img);
out=zeros(M,N);
for i=1:M
    for j=1:N
        tile=tempOut(i:i+n-1,j:j+n-1);
        out(i,j)=max(tile(:));
    end
end
out=uint8(out);
end