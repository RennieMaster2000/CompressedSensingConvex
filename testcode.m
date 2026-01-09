load("cs.mat")

z = zeros(size(x));
zcons = projAx_b(z,F_us,X_us);
sum(abs(F_us*zcons-X_us))