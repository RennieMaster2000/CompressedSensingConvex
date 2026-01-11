% CVX_Linear.m uses Linear Program notation (Expected 8 iterations)
% CVX.m uses l1 notation (Expected 11 iterations)

clc; clear; close all;
load('cs.mat');


N = n;

cvx_begin
    variable x_hat(N)
    minimize( sum(x_hat) )
    subject to
        F_us * x_hat == X_us
        x_hat >= 0
cvx_end

% Plot
figure;
stem(x, 'k', 'LineWidth', 1.5); hold on;
stem(x_hat, 'r--');
legend('True signal', 'Reconstructed signal');
title('Reconstruction using CVX');
xlabel('Index'); ylabel('Amplitude');
grid on;

% Reconstruction error
reconstruction_error = norm(x - x_hat) / norm(x);
fprintf('Relative reconstruction error: %.4e\n', reconstruction_error);
