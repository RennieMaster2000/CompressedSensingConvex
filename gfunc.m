function [g] = gfunc(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
g=zeros(size(x));
for i = 1:length(g)
    if x(i)>0
        g(i)=1;
    elseif x(i)<0
        g(i)=-1;
    else
        g(i)=0;
    end
end
end