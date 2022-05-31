function net = cal_f(net, X)
% f: (N, 1)
% X: (N, K + 1)

H       = X * net.Wjk;
net.ACT = sigmoid(H);
Z       = [X(:, 1) net.ACT];
net.f   = Z * net.wj;
