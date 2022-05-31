function [MSE, net, ite] = train_MLP(engine, data, net, stop_conds)

if strcmp(engine, 'BFGS')
    [trained_net, ite] = BFGS(data, net, stop_conds);
elseif strcmp(engine, 'SD')
    [trained_net, ite] = SD(data, net, stop_conds);
end

MSE = trained_net.MSE;

net.wj  = trained_net.wj;
net.Wjk = trained_net.Wjk;

