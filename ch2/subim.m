function s = subim(f,m,n,rx,cy)
%Extra a subimage

s=zeros(m,n);
rowhigh = rx+m-1;
colhigh = cy+n-1;
xcount=0;
for r = rx:rowhigh
    xcount = xcount+1;
    ycount = 0;
    for c =cy:colhigh
        ycount =ycount+1;
        s(xcount,ycount)=f(r,c);
    end
end