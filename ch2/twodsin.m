function [rt,f,g]=twodsin(A,u0,v0,M,N)
tic
for r=1:M
    u0x=u0*(r-1);
    for c=1:N
        v0y=v0*(c-1);
        f(r,c)=A*sin(u0x+v0y);
    end
end
t1=toc;
tic
r=0:M-1;
c=0:N-1;
[C,R]=meshgrid(c,r);
g=A*sin(u0*R+v0*C);
t2=toc;
rt=t1/(t2+eps);