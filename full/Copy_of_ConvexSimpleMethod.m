clear; clc;
load('cs.mat');
N = n;

max_iter = 100;
L=0.5;
tol = 1e-6;


A = F_us;
b = X_us;

xold = ones(N,1)/2; %initial
fbest = n;%ffunc(xold);
xbest = xold;
kbest = 0;

iter = 0;
for k = 1:max_iter

    %Polyak step
    gamma = 1/k;
    if k <= 11
        alpha = gamma;
    else
        alpha = ffunc(xold)-fbest+gamma; % does not work due to f_best being outside constraints
        %alpha
    end
    alpha
    %alpha = alphafunc(k,L);
    xnew = xold - alpha*gfunc(xold);% Subgradient step 
    xnew = projAx_b(xnew,A,b);  % Projection onto equality constraint
    xnew = max(real(xnew), 0);  % Projection onto nonnegativity

    fnew = ffunc(xnew)

    iter = k;

    if fnew < fbest && k>10
        fbest = fnew;
        xbest = xnew;
        kbest = k;
    end
    if norm(xnew - xold) < tol && k>10% Stop when within tolerance
        break 
    end
    
    xold = xnew;
end
%fbest = fnew;
fbest
kbest
%xbest = xnew;
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