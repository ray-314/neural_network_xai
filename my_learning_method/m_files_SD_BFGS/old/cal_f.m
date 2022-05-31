function net = cal_f(X, net)

net.Z = sigmoid(net.W' * X')';

net.f = net.v(1) + net.Z * net.v(2 : end);
