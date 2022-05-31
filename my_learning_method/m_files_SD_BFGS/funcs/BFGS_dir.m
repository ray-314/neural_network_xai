function net = BFGS_dir(net)

w  = [net.wj;    net.Wjk(:)];
dw = [net.dE_dwj; net.dE_dWjk(:)];

if net.Hcounter == 0 %|| net.M < net.Hcounter 
    net.G = eye(net.M); % approximation of the Hessian matrix
else
    P     = w - net.w_old;
    Q     = dw - net.dw_old;
    PdQ   = P' * Q;
    PPd   = P * P';
    GQ    = net.G * Q;
    GQPd  = GQ * P';
    net.G = net.G + ((1 + Q'*GQ/PdQ) * PPd - ( GQPd + GQPd') ) / PdQ;
end
net.Hcounter = net.Hcounter + 1;

net.w_old  = w;
net.dw_old = dw;

dir = - net.G * dw;

% in the case that the G is not a positive definite matrix
if net.Hcounter ~= 1 && dw' * -dir < 0
    dir          = -dw;
    net.Hcounter = 0;
end
temp = sqrt(dir.' * dir);
dir = dir ./ temp;
%

net.dir_wj  = dir(1 : net.J + 1, 1);
net.dir_Wjk = reshape(dir(2 + net.J : end, 1), net.K + 1, net.J);
