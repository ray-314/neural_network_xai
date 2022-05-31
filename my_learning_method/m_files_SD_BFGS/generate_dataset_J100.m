function [X, y] = generate_dataset_J100

% X: (N, K + 1)
N = 500;
K = 10;
X = rand(N, K);
X = [ones(N, 1), X];

net.J = 100;
net.K = K;
net.N = N;

% v: (J + 1, 1)
%net.wj = [-0.2821; -7.8072; 3.8681];
net.wj = 2 * rand(net.J + 1, 1) - 1;
% W: (K + 1, J)
net.Wjk = 6 * rand(net.K + 1, net.J) - 3;
%net.Wjk = [-1.8340  0.4452;
%         -1.5278 -2.2559
%          1.5469  2.2753];

net = cal_f(net, X);

y = net.f + randn(N, 1) * 0.1;


