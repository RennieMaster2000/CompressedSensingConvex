clear; clc;
load('cs.mat');
N = n;

max_iter = 1000;
L=0.1;
tol = 1e-6;


A = F_us;
b = X_us;

fbest = ffunc(b);
xbest = zeros(N,1);
xold = zeros(N,1);

iter = 0;
for k = 1:max_iter

     
    xnew = ituncon(xold,n,L);   % Subgradient step
    xnew = projAx_b(xnew,A,b);  % Projection onto equality constraint
    xnew = max(real(xnew), 0);  % Projection onto nonnegativity

    fnew = ffunc(xnew);

    iter = k;
    if norm(xnew - xold) < tol %Stop when within tolerance
        break 
    end
    
    xold = xnew;
end

fbest=fnew;
xbest=xnew;

fprintf('Algorithm stopped after %d iterations\n', iter);

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