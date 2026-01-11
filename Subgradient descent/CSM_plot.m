clear; clc;
load('cs.mat');
N = n;

max_iter = 5000;
L=0.5; 
tol = 1e-5;

A = F_us;
b = X_us;

xold = ones(N,1)/2; %initial
fbest = n;
xbest = xold;
kbest = 0;

fstar = 3;  % Determined using CVX
f_hist = zeros(max_iter,1);     % Track history of f

iter = 0;

tic;
for k = 1:max_iter
    %Polyak step
    gamma = 15/k;
    if k <= 11
        alpha = gamma;
    else
        alpha = ffunc(xold)-fbest+gamma;
    end

    gnormed = gfunc(xold);
    alpha = alpha/(norm(gnormed)^2); %normalising step size

    xnew = xold - alpha*gnormed;% Subgradient step 
    xnew = projAx_b(xnew,A,b);  % Projection onto equality constraint
    xnew = max(real(xnew), 0);  % Projection onto nonnegativity

    fnew = ffunc(xnew);
    f_hist(k) = fnew;

    iter = k;

    if fnew < fbest && k>10
        fbest = fnew;
        xbest = xnew;
        kbest = k;
    end

    if norm(xnew - xold) < tol && k>10 % Stop when within tolerance
        break 
    end
    
    xold = xnew;
end
cpu_time_lc = toc;

f_hist = f_hist(1:iter);

fprintf('Algorithm stopped after %d iterations\n', iter);

%% Convergence plot: |f(k) - f*|
gap = abs(f_hist - fstar);

figure;
stairs(1:iter, gap, 'b', 'LineWidth', 1.5);
set(gca, 'YScale', 'log');
title('Convergence Plot');
xlabel('$k$', 'Interpreter', 'latex');
ylabel('$|f^{(k)} - f^\star|$', 'Interpreter', 'latex');
grid on;

%% Plot
figure;
stem(x, 'k', 'LineWidth', 1.5); hold on;
stem(xbest, 'r--');
legend('True signal', 'Low-complexity reconstruction');
title('Reconstruction using projected subgradient method');
xlabel('Index'); ylabel('Amplitude'); grid on;

%% Report error
fprintf('Relative reconstruction error (low-complexity): %.4e\n', ...
    norm(x - xbest) / norm(x));

fprintf('CPU time: %.4f s\n', cpu_time_lc);