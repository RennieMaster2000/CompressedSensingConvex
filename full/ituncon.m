function [xnew] = ituncon(xold,k,L)
%Single unconstrained iteration
%   Detailed explanation goes here
xnew = xold - alphafunc(k,L)*gfunc(xold);
end