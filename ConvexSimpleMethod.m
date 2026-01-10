clear all
load("cs.mat")
L=1;

xold = ones(size(X_us));
fbest = ffunc(xold);
xbest = xold;
for n = 0:9
    xnew = projAx_b(ituncon(xold,n,L),F_us,X_us);
    fnew = ffunc(xnew);
    if fnew<fbest
        xbest = xnew;
        fbest = fnew;
    end
    xold=xnew;
end
fbest
score = sum(abs(xbest-x),"all")

