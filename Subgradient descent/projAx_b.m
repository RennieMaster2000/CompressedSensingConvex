function [xproj] = projAx_b(x,A,b)
% Projection Ax=b formula
%xproj = x - A' * (pinv(A*A') * (A*x-b));
xproj = x - A' * (A*x-b);
end

