%function [g] = gfunc(x)
%g=zeros(size(x));
%for i = 1:length(g)
%    if x(i)>0
%        g(i)=1;
%    elseif x(i)<0
%        g(i)=-1;
%    else
%        g(i)=0;
%    end
%end
%end


function g = gfunc(x)
    g = zeros(size(x));
    g(x > 0) = 1;
    g(x < 0) = -1;
end