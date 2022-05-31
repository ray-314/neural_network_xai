if exist('y', 'var')
    Y = y;
end

OutLayer1 = logsig(net.IW{1} * X_no_cnstnt +net.b{1}); 
F = purelin(net.LW{2} * OutLayer1+net.b{2}); 

all(all(abs(net(X_no_cnstnt) - F) < 10^-12 ))

MSE = mse(net, y, F);

fprintf("%.8f\n", MSE)

fprintf("%.8f\n", mean(mean((y - F).^2)))


