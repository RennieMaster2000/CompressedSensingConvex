function [g] = gfunc(x)
% gradient function g(x)
g=zeros(size(x));
for i = 1:length(g)
    if x(i)>0
        g(i)=1;
    elseif x(i)<0
        g(i)=-1;
    else
        g(i)=1; 
    end
end
end