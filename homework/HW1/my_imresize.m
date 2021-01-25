% image resize function
% I is the inut image
% newSize is the size of the image after scaled
% method is the interpolation methos
function out=my_imresize(I,newSize,method)

if strcmp(method, 'nearest')
    out=zeros(newSize);
    oldSize=size(I);
    scale=newSize./oldSize;
    for i=1:newSize(1)
        for j=1:newSize(2)
            map=floor([i-1 j-1]./scale);
            map=map+1;
            out(i,j)=I(map(1),map(2));
        end
    end
elseif strcmp(method, 'bilinear')
    out=zeros(newSize);
    oldSize=size(I);
    scale=newSize./oldSize;
    for i=1:newSize(1)
        for j=1:newSize(2)
            pos=[i-1 j-1]./scale;
            map=floor(pos);
            uv=pos-map;u=uv(1);v=uv(2);
            map=map+1;
            if map(1)==oldSize(1)
                map(1)=map(1)-1;
            end
            if map(2)==oldSize(2)
                map(2)=map(2)-1;
            end
            out(i,j)=u*v*I(map(1)+1,map(2)+1)+(1-u)*(1-v)*I(map(1),map(2))...
                +u*(1-v)*I(map(1)+1,map(2))+(1-u)*v*I(map(1),map(2)+1);
        end
    end
elseif strcmp(method, 'bicubic')
    out=zeros(newSize);
    oldSize=size(I);
    scale=newSize./oldSize;
    I_pad=zeros(oldSize+4);
    I_pad(3:oldSize(1)+2,3:oldSize(2)+2)=I(:,:);
    for i=1:newSize(1)
        for j=1:newSize(2)
            map_i = floor(i/scale(1))+2;  u = rem(i,scale(1))/scale(1);
            map_j = floor(j/scale(2))+2; v = rem(j,scale(2))/scale(2);
            A = [s(u+1),s(u),s(u-1),s(u-2)];
            C = [s(v+1);s(v);s(v-1);s(v-2)];
            B = I_pad(map_i-1:map_i+2,map_j-1:map_j+2);
            out(i,j) = A*B*C;
        end
    end    
end

out=uint8(out);

end



% Bicubic Interpolation kernel function
function w = s(wx)
    wx = abs(wx);
    if wx<1
        w = 1 - 2*wx^2 + wx^3;
    elseif wx>=1 && wx<2
        w = 4 - 8*wx + 5*wx^2 - wx^3;
    else
        w = 0;
    end
end