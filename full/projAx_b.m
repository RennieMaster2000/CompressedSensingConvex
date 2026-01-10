function [xproj] = projAx_b(x,A,b)
%PROJAX_B Summary of this function goes here
%   Detailed explanation goes here
%xproj=x-transpose(A)*pinv(A*transpose(A))*(A*x-b);
xproj = x - A' * (pinv(A*A') * (A*x-b));
end

