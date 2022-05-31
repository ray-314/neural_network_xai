

figure
% for J = 2
%     for seed = 1 : 5
for J = 1 : 10
    for seed = 1 : 5
        filename = ['learned_NNs/NN1_exp2_', num2str(J), '_', num2str(seed), '.mat'];
        
        load(filename)
        OutLayer1 = logsig(net.IW{1} * X_no_cnstnt + net.b{1}); 
        F = purelin(net.LW{2} * OutLayer1 + net.b{2}); 
%         F = purelin(net.LW{2} * OutLayer1); 
        MSE = mse(net, Y, F);
        fprintf("J = %d, seed = %d, MSE = %g\n", J, seed, MSE)
        
        semilogy(J, MSE, 'xk')
        hold on
    end
end


ax = axis;
%axis([1, 200, 10^-4, 10^-2])
axis(ax)
grid on
fs = 20;
% set(gca, 'XScale', 'log')
% set(gca, 'YScale', 'log')
% set(gca, 'XTick', get(gca, 'XTick'))
% %set(gca, 'XTick', 0 : 100 : 1000)
% set(gca, 'YTick', get(gca, 'YTick'))
% legend({'ELM', 'K-means', 'newrb', 'SD', 'BFGS', ...
%     'RBF-SSF', 'RBF-SSF-pH'}, ...
%     'Location', 'northeast')
xlabel('J', 'FontSize', fs, 'FontAngle', 'italic')
ylabel('MSE', 'FontSize', fs, 'FontAngle', 'italic')
set(gca, 'FontSize', fs)
set(findobj(gca, 'Type', 'Line'), 'LineWidth', 2)
set(findobj(gca, 'Type', 'Line'), 'MarkerSize', 10)
set(gcf, 'PaperPositionMode', 'auto')
%print('-depsc', ['trainMSE_' dataname '_ns10.eps']);

% set(gca, 'XScale', 'linear')
% set(gca, 'XTick', 0 : 200 : 1000)
% set(gca, 'XTick', 0 : 10 : 100)
% legend off
print('-depsc', 'MSE_exp2.eps');
