clear
close all

[X_no_cnstnt, Y] = data_for_NN_cmp2_exp1;
I = size(Y, 1);

rng(1)
J = 10;
A = rand(J, I);

H = A * Y;

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


