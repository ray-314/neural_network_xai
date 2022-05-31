function [X, y] = generate_dataset20190107

% X: (N, K + 1)
N = 500;
X = rand(N, 2);
X = [ones(N, 1), X];

net.J = 2;
net.K = 2;
net.N = N;

% v: (J + 1, 1)
net.wj = [-0.2821; -7.8072; 3.8681];
% W: (K + 1, J)
%net.W = 2 * rand(net.K + 1, net.J) - 1;
net.Wjk = [-1.8340  0.4452;
         -1.5278 -2.2559
          1.5469  2.2753];

net = cal_f(net, X);

y = net.f;


