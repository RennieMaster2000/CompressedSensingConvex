L=1;
b = [0.1, 0.5,-1,0];

fbest = ffunc(b)
xbest = b
xold = b
for n = 0:9
    xnew = ituncon(xold,n,L);
    fnew = ffunc(xnew);
    if fnew<fbest
        xbest = xnew;
        fbest = fnew;
    end
    xold=xnew
end
fbest
xbest

