function  E = cal_E(net, y)

E = (net.f - y)' * (net.f - y) / 2;
