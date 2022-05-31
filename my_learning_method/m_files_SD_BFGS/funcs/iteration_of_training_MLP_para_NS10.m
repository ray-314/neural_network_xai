function [MSE_array, w_mat, ite_array, cpu_time] ...
    = iteration_of_training_MLP_para_NS10(engine, data, J)

net.J = J;
net.N = size(data.X, 1);
net.K = size(data.X, 2) - 1;
net.M = 1 + J + J * (net.K + 1);

%%% variables %%%
seed_nums = 1 : 10;

% initial weight range (ini_w_min, ini_w_min + ini_w_range)
ini_w_min   = -1;
ini_w_range = 2;

% stop conditions
%stop_conds.max_ite  = 10000;
stop_conds.max_ite  = 1000;
%stop_conds.step_len = 10^-6;
stop_conds.step_len = 10^-8;
% MATLAB default
% If the magnitude of the gradient is less than 1e-5, the training will stop. 
%%%%%%%%%%%%%%%%%

%%% filename %%%
address = char(java.net.InetAddress.getLocalHost);
dirname   = 'results\';

filename2save = [address([1 : 2, end - 1 : end]) '_' data.name '_' engine ...
    '_J_' num2str(net.J)];
    %'_lam_' num2str(lambda, '%.0g') ];

if ~exist(dirname, 'dir')
    mkdir(dirname)
end
filename = [dirname filename2save '.mat'];
%%%%%%%%%%%%%%%%

if exist(filename,'file')
    load(filename)
    % end
else
    fprintf('J = %d\n', J)
    
    %%% variables to save %%%
    MSE_array  = zeros(1, length(seed_nums));
    ite_array  = zeros(1, length(seed_nums));
    w_mat      = zeros(net.M, length(seed_nums));
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    s_time  = datetime;
    net_old = net;
    parfor ii = 1 : length(seed_nums)
        net = net_old;
        
        fprintf('%d : ', seed_nums(ii))
        
        %%% initialize weights %%%
        rng(seed_nums(ii),'twister')
        net.wj = rand(net_old.J + 1, 1) * ini_w_range + ini_w_min;
        net.Wjk = rand(net_old.K + 1, net_old.J) * ini_w_range + ini_w_min;
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% train %%%
        [MSE_array(ii), w_mat(:, ii), ite_array(ii)] ...
            = train_MLP(engine, data, net, stop_conds);
        %%%%%%%%%%%%%
    end
    cpu_time = seconds(datetime - s_time);
    
    %%% save the result %%%
    save(filename, 'MSE_array', 'ite_array', 'w_mat', 'cpu_time')
    %%%%%%%%%%%%%%%%%%%%%%%
end



