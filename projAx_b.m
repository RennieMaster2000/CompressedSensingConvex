function [xproj] = projAx_b(x,A,b)
%PROJAX_B Summary of this function goes here
%   Detailed explanation goes here
xproj=x-A'*pinv(A*A')*(A*x-b);
end

