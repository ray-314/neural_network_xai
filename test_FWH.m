

F_cmp = net_cmp.LW{2} * H_cmp + net_cmp.b{2}; 
H2_cmp = [H_cmp; ones(1, N)];
W      = [net_cmp.LW{2}, net_cmp.b{2}];
F2_cmp = W * H2_cmp; 

max(max(abs(F_cmp - F2_cmp)))

A = H2_cmp' \ F2_cmp';

W - A'

max(max(abs(H2_cmp - A' \ F2_cmp)))
