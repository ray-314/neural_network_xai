% clear
% close all
% 
% % [X_no_cnstnt, Y] = data_for_NN1_exp2;
% 
% load('data_generatn_experiment1_A1_414.mat')
% Y = double(B1);
% constant_pixels = min(Y') - max(Y') == 0;
% Y = Y(~constant_pixels, :);


rng(1)
J = 10;
A = rand(J, 3);

H = A * Y;

rng(4)

% tilde_Y  = fastica(H);

% rica
Mdl    = rica(H', 3);
tilde_Y = transform(Mdl, H');
tilde_Y = tilde_Y';

figure(1)

for jj = 1 : 3
    subplot(3, 1, jj);
    plot(Y(jj, :))
end
figure(2)
n_ICs = size(tilde_Y, 1);
for jj = 1 : n_ICs
    subplot(n_ICs, 1, jj);
    plot(tilde_Y(jj, :))
end


