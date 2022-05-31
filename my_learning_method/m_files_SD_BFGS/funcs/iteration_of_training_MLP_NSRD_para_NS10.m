function [MSE_array, w_mat, ite_array, cpu_time] ...
    = iteration_of_training_MLP_NSRD_para_NS10(engine, data, J)

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
dirname   = 'results_NSRD\';

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
    
    %%% load optimal solution with J - 1 hidden units %%%
    if J > 1
        filename2load = [address([1 : 2, end - 1 : end]) '_' data.name ...
            '_' engine '_J_' num2str(net.J - 1)];
        load([dirname filename2load '.mat'])
        [unused, ix] = min(MSE_array);
        w_Jm1 = w_mat(:, ix);
        
        wj_Jm1  = w_Jm1(1 : net.J, 1);
        Wjk_Jm1 = reshape(w_Jm1(1 + net.J : end, 1), net.K + 1, net.J - 1);
    else
        wj_Jm1  = [];
        Wjk_Jm1 = [];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
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
        if J == 1
            net.wj  = rand(2, 1) * ini_w_range + ini_w_min;
            net.Wjk = rand(net_old.K + 1, 1) * ini_w_range + ini_w_min;
        else
            net.wj  = [wj_Jm1; rand(1, 1) * ini_w_range + ini_w_min];
            net.Wjk = [Wjk_Jm1, rand(net_old.K + 1, 1) ...
                * ini_w_range + ini_w_min];
        end
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



