function net = SD_dir(net)

dw = [net.dE_dwj; net.dE_dWjk(:)];

dir = - dw;

temp = sqrt(dir.' * dir);
dir = dir ./ temp;
%

net.dir_wj  = dir(1 : net.J + 1, 1);
net.dir_Wjk = reshape(dir(2 + net.J : end, 1), net.K + 1, net.J);
