load('cs.mat');

N = n;

% Algorithm Parameters
max_iter = 1000;
tol = 1e-6; %can be implemented to stop loop sooner by looking at convergence (right now its looping
%up to 1000

L=10;

% Precompute projection matrix contrain Ax=b
A = F_us;
b = X_us;
P = eye(N) - A' * (pinv(A*A') \ A);

%Initialization
x_0 = A' * (pinv(A * A') \ b); % least squares or something, there is like 1 line somewhere in those stanford notes suggesting this
%x_0 = max(x_0, 0); % projection X => 0
fbest = ffunc(x_0);
xbest = x_0;
xold = x_0;

objective_vals = zeros(max_iter, 1);
errors = zeros(max_iter, 1);
times = zeros(max_iter, 1);


tic;
for k = 1:max_iter

    g = sign(xold);
    g(xold == 0) = 0;

    xnew = xold - alphafunc(k,L) * P * g; %Update using formula with projection Ax=b
    xnew = max(xnew, 0); % Project on constraint X >= 0;
    
    objective_vals(k) = sum(abs(xnew));
    errors(k) = norm(x - xnew) / norm(x);
    times(k) = toc;

    if k > 1 && abs(objective_vals(k) - objective_vals(k-1)) < tol
        fprintf('Converged at iteration %d\n', k);
        max_iter = k;
        objective_vals = objective_vals(1:k);
        errors = errors(1:k);
        times = times(1:k);
        break;
    end

    xold = xnew;
end
time_lowcomp = toc;

xbest = xnew;
fbest = objective_vals(end);

fbest
xbest

