function net = update_weights(net)

net.wj = net.wj + net.eta * net.dir_wj;

net.Wjk = net.Wjk + net.eta * net.dir_Wjk;

