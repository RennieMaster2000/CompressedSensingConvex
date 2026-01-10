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
        g(i)=1; %-0.5; % This should be '1' look at linear program expression
        % 1^T*x, x >= 0 -> derivate is '1' for x => 0, thus x > 0 and x = 0
        %Additionally look at convergence plot 
        %look at -0.5 (jittery) and 1 (smooth)
        %or does that jitter not matter much?
        %i do notice with -0.5, despite jitter it converges slighty faster?
        %but also does always goes to set max iterations (tolerance wont work
        %due to viotile behaviour), (when g=1 tolerance do get reached, and stops
        %iterations before set max iterations)
    end
end
end
