clear
close all

[y1, y2, y3] = meshgrid(1 : 3, 1 : 3, 0 : 1);

I = 3;
Y = [y1(:), y2(:), y3(:)];
Y = Y';

rng(1)
J = 10;
A = rand(J, I);

H = A * Y;

rng(4)

tilde_Y  = fastica(H);

% rica
% Mdl    = rica(H', I);
% tilde_Y = transform(Mdl, H');
% tilde_Y = tilde_Y';

figure(1)

for ii = 1 : I
    subplot(I, 1, ii);
    plot(Y(ii, :))
end
figure(2)
n_ICs = size(tilde_Y, 1);
for jj = 1 : n_ICs
    subplot(n_ICs, 1, jj);
    plot(tilde_Y(jj, :))
end


