close all
clear

addpath(genpath('funcs'))


%%%%%%%%%%% data generation %%%%%%%%%
[data.X, data.y] = generate_dataset20190107;

N = length(data.y);
K = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% display the dataset %%%%%%%%
figure
plot3(data.X(:, 2), data.X(:, 3), data.y, '*')
grid on
view(-64.3, 23.2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% net's parameters %%%%%%%
net.J = 2;
net.K = K;
net.N = N;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% initialize theta %%%%%%%%%%
rng(3, 'twister');
% wj: (J + 1, 1)
net.wj = 2 * rand(net.J + 1, 1) - 1;
% W: (K + 1, J)
net.Wjk = 2 * rand(net.K + 1, net.J) - 1;

% noise = 10;
% net.v = net.v + 2 * noise * rand(size(net.v)) - noise; 
% net.W = net.W + 2 * noise * rand(size(net.W)) - noise; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% parameters for learning %%%%%%
addpath(genpath('funcs'))
% 最大更新回数
stop_conds.max_ite  = 1000;
%stop_conds.step_len = 10^-6;
% 直線探索の最小値
stop_conds.step_len = 10^-8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% train %%%
%engine = 'BFGS';
engine = 'SD';
% MSE: 平均事情誤差
% net: 学習後
% ite: 繰り返し回数
[MSE, net, ite] = train_MLP(engine, data, net, stop_conds);
%%%%%%%%%%%%%

%%%%%% display f after learning %%%%%%%
net = cal_f(net, data.X);
hold on
plot3(data.X(:, 2), data.X(:, 3), net.f, '*r')
legend('y', 'f')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
