clear
close all

addpath('FastICA_25')
% IC = fastICA_on_H(H);

%%%%%%%%% Prepare the movie %%%%%%%%%%
[X_no_cnstnt, Y] = data_for_NN1_exp1;
% [X_no_cnstnt, Y] = data_for_NN_cmp_exp1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rng(2)
%%%%%%%%%%%% NN1 %%%%%%%%%%%%%
load('learned_NNs/NN1_exp1_3_4.mat', 'net')
% load('learned_NNs\NN1_exp1_10_1.mat')
% load('learned_NNs\NN1_exp1_2_14_5.mat', 'net')

% Y = y;
N = size(Y, 2);

net_1 = net;
H_1 = logsig(net_1.IW{1} * X_no_cnstnt + net_1.b{1});
% H_1 = (H_1 - repmat(mean(H_1, 2), 1, N)); % normalization
% H_1 = (H_1 - repmat(mean(H_1, 2), 1, N)) ...
%     ./ repmat(std(H_1, 0, 2), 1, N); % normalization

% fastica
% ICs_1  = fastica(H_1);

% rica
%%rica：特徴量抽出
%%rica(x,q)は、qはxから抽出する特徴量の個数であり、ricaはp（変数の個数）行q列の変換の重み行列を学習する
%%Mdl = rica(x,q);
%%学習済みの変換を使用してxを新しい一連の特徴量に変換するには、Mdlとxをtransformに渡す
%%y1 = transform(Mdl, x);
Mdl    = rica(H_1', 3);
IC_1 = transform(Mdl, H_1');
ICs_1 = IC_1';

% sobi
% winv = sobi(H_1);
% ICs_1  = winv \ H_1;

display_ICs(H_1, 'H_1_exp1', 'h')
display_ICs(ICs_1, 'ICs_1_exp1', 'p')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%% NN_cmp %%%%%%%%%%%%%
load('learned_NNs/NN1_exp1_10_3.mat', 'net')
% load('learned_NNs\NN_cmp_exp1_10_5.mat', 'net')
% load('learned_NNs\NN1_exp1_10_1.mat', 'net')
N = size(Y, 2);

net_cmp = net;
H_cmp   = logsig(net_cmp.IW{1} * X_no_cnstnt + net_cmp.b{1});
F_cmp = net_cmp.LW{2} * H_cmp + net_cmp.b{2}; 
% H2_cmp = [H_cmp; ones(1, N)];

% H_cmp = (H_cmp - repmat(mean(H_cmp, 2), 1, N)); % normalization
% H_cmp = (H_cmp - repmat(mean(H_cmp, 2), 1, N)) ...
%     ./ repmat(std(H_cmp, 0, 2), 1, N); % normalization

% fastica
% ICs_cmp  = fastica(H_cmp);

% rica
Mdl_cmp    = rica(H_cmp', 10);
IC_cmp = transform(Mdl_cmp, H_cmp');
ICs_cmp = IC_cmp';

% sobi
% winv = sobi(H_cmp);
% ICs_cmp  = winv \ H_cmp;

display_ICs(H_cmp, 'H_cmp_exp1', 'g')
display_ICs(ICs_cmp, 'ICs_cmp_exp1', 'q')
% for ii = 1 : size(ICs_cmp, 1)
%     figure
%     plot(1 : size(ICs_cmp, 2), ICs_cmp(ii, :))
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

display_heatmap(H_1, H_cmp, 'H_heatmap_exp1', 'g', 'h', [360 198 560 420 / 2])
h = display_heatmap(ICs_1, ICs_cmp, 'ICs_heatmap_exp1', 'q', 'p', [360 198 560 420 / 2]);

