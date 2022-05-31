function net = cal_dE(net, X)

net.dACT    = net.ACT .* (1 - net.ACT);
net.dE_dwj  = [X(:, 1) net.ACT].' * net.f_y;
net.dE_dWjk = X.' * (net.dACT .* (net.f_y * net.wj(2 : end).'));

