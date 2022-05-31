function net = cal_g(y, X, net)

delta = net.f - y;


%%%%%%% d_v %%%%%%%%
net.d_v(1)                = sum(delta);
net.d_v(2 : net.J + 1, 1) = net.Z' * delta;
%%%%%%%%%%%%%%%%%%%%

%%%%%%% d_W %%%%%%%%
net.d_W = (repmat(delta, 1, net.K + 1) .* X)' ...
    * (repmat(net.v(2 : end), 1, net.N) .* dsigmoid(net.Z)')';
%%%%%%%%%%%%%%%%%%%%
