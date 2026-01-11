clear; clc;
load('cs.mat');
N = n;

max_iter = 5000;
L=0.5; 
tol = 1e-5; %1e-6

A = F_us;
b = X_us;

xold = ones(N,1)/2; %initial
fbest = n;%ffunc(xold);
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
        alpha = ffunc(xold)-fbest+gamma; % does not work due to f_best being outside constraints
        %alpha
    end
    alpha
    %alpha = alphafunc(k,L);
    gnormed = gfunc(xold);
    alpha = alpha/(norm(gnormed)^2);%normalising step size
    %gnormed = gnormed/sum(abs(gnormed),"all"); %L1 normed
    %gnormed = gnormed/norm(gnormed); %L2 normed
    xnew = xold - alpha*gnormed;% Subgradient step 
    xnew = projAx_b(xnew,A,b);  % Projection onto equality constraint
    xnew = max(real(xnew), 0);  % Projection onto nonnegativity

    fnew = ffunc(xnew);
    f_hist(k) = fnew;

    iter = k;

    %This is fnew <fbest code is broken/ wont work here, fbest is like 2 according to code. (Real fbest is 3 using CVX),
    %this '2' gets achieved early on eventhough the associated reconstructed x signal is wrong. 
    % for early k: 2 -> f slowly increase to higher value, at certain k it
    % 'peaks' (still happens also quite early) and later on for later k it
    % slowly goes down and converges towards 3! 
    % -> in other words, fnew < fbest will never happen for higher k
    % because it happens early on for k, to get correct f and x, simpely
    % take the values at the last k iteration

    %if fnew < fbest 
    %    fbest = fnew;
    %    xbest = xnew;
    %end
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
cpu_time_lc = toc;

f_hist = f_hist(1:iter);
%fbest = f_hist(iter);
%xbest = xnew;

fprintf('Algorithm stopped after %d iterations\n', iter);

%% Convergence plot: |f(k) - f*| % Is this correct?
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