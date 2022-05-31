function net = cal_MSE(net, data)

net = cal_f(net, data.X);

net.f_y = net.f - data.y;

net.MSE = 1 / net.N * net.f_y.' * net.f_y;
