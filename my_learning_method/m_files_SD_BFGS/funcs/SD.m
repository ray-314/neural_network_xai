function [net, ite] = SD(data, net, stop_conds)

%%%%%%%%%%%%%% input variables %%%%%%%%%%%%%%%
% stop_conds : stopping conditions
%              max_ite  : max number of iterations
%              step_len : lower limit of the step length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

net.M        = 1 + net.J + net.J + net.J * net.K;

net = cal_MSE(net, data);

for ite = 1 : stop_conds.max_ite
    %%% calculate the gradient %%%
    net = cal_dE(net, data.X);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% line search %%%
    net     = SD_dir(net);
    
    net.eta = 1;
    net_old = net;
    while 1
        net = update_weights(net_old);
        
        % calculate E
        net = cal_MSE(net, data);
        
        if net.MSE < net_old.MSE
            break
        end
        
        net_old.eta = 0.1 * net_old.eta;
        
        if net_old.eta < stop_conds.step_len
            % in the case that G is the unit matrix
            break
        end
    end
    %%%%%%%%%%%%%%%%%%%
    
    %%% end if the step_len criterion is met %%%
    if net_old.eta < stop_conds.step_len
        net = net_old;
        break
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

fprintf('J = %d, ite = %d, MSE = %g\n', net.J, ite, net.MSE)

