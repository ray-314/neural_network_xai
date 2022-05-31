% clear
% close all

[X_no_cnstnt, Y] = data_for_NN1_exp2;
I = size(Y, 1);

rng(1)
J = 1000;
A = rand(J, I);

% Y = Y + (rand(size(Y)) - 0.5) * 10^-1;
% H = A * Y;
H = W' * Y;

rng(3)

tilde_Y  = fastica(H);

% rica
% Mdl    = rica(H', 3);
% tilde_Y = transform(Mdl, H');
% tilde_Y = tilde_Y';

figure(1)
for jj = 1 : I
    subplot(I, 1, jj);
    plot(Y(jj, :))
end
figure(2)
n_ICs = size(tilde_Y, 1);
for jj = 1 : n_ICs
    subplot(n_ICs, 1, jj);
    plot(tilde_Y(jj, :))
end


