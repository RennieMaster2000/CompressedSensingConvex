function p = project_to_affine(A, b, z)
% project_to_affine Projects point z onto the affine set {x | Ax = b}
% 
% Inputs:
% A - A matrix (m x n, where m is the number of constraints)
% b - A vector (m x 1)
% z - The point to project (n x 1)
%
% Output:
% p - The projection of z onto the set (n x 1)

% Check if AAT is singular (optional, but good for robustness)
if cond(A * A') > 1e10
    error('Matrix A*A'' is ill-conditioned. The solution might be unstable.');
end

% Calculate the projection using the formula
% (A * A') \ (A * z - b) is the most efficient way to solve the linear system
p = z - A' * ((A * A') \ (A * z - b));

end