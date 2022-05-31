function Hessian = Hessian_sig(net, X)

%%% input %%%
% net.
%   wj
%   Wjk
%   ACT
%   dACT
%   f
%   f_y
%%%%%%%%%%%%%

%%% output %%%
%Hessian : (1 + J + J * (K + 1), 1 + J + J * (K + 1))
%%%%%%%%%%%%%%

J = net.J;
K = net.K;
N = net.N;
M = net.M;  % the number of weights

%%% commonly used %%%
Z     = [X(:, 1) net.ACT]; % (N,J+1)
delta = net.f_y;
dS    = net.dACT; %  (N,J)
wjdS  = repmat(net.wj(2 : end)', N, 1) .* dS;
%%%%%%%%%%%%%%%%%%%%%

H = zeros(M);
% column variable
for i = 1:M
    % row variable 
    for j = i:M
        % columns of wj
        if i <= J+1
            % rows of wj
            if j <= J+1
                J1     = i - 1;
                J2     = j - 1;
                H(j,i) = Z(:,J1+1)' * Z(:,J2+1);
                H(i,j) = H(j,i);
            % rows of wjk
            else
                J1 = i - 1;
                jj = j - (J+1);
                K1 = mod(jj-1,K+1);
                J2 = ceil(jj/(K+1));
                if J1 == J2
                    %H(j,i) = (wj(J2+1)*dS(:,J2).*Z(:,J1+1) + delta.*dS(:,J1))' * X(:,K1+1);
                    H(j,i) = (wjdS(:,J2).*Z(:,J1+1) + delta.*dS(:,J1))' * X(:,K1+1);
                else
                    %H(j,i) = (wj(J2+1)*dS(:,J2).*Z(:,J1+1))' * X(:,K1+1);
                    H(j,i) = (wjdS(:,J2).*Z(:,J1+1))' * X(:,K1+1);
                end
                H(i,j) = H(j,i);
            end
        % columns of wjk
        else
            ii = i - (J+1);         % ii = 1`J*K
            K1 = mod(ii-1,K+1);
            J1 = ceil(ii/(K+1));
            jj = j - (J+1);
            K2 = mod(jj-1,K+1);
            J2 = ceil(jj/(K+1));
            if J1 == J2
                %H(j,i) = wj(J1+1) * (wj(J2+1)*dS(:,J2) + delta.*(1-2*Z(:,J1+1)))' * (dS(:,J1).*X(:,K1+1).*X(:,K2+1));
                H(j,i) = net.wj(J1+1) * (wjdS(:,J2) + delta.*(1-2*Z(:,J1+1)))' * (dS(:,J1).*X(:,K1+1).*X(:,K2+1));
            else
                %H(j,i) = wj(J1+1) * (wj(J2+1)*dS(:,J2))' * (dS(:,J1).*X(:,K1+1).*X(:,K2+1));
                H(j,i) = net.wj(J1+1) * (wjdS(:,J2))' * (dS(:,J1).*X(:,K1+1).*X(:,K2+1));
            end
            H(i,j) = H(j,i);
        end
%         if i == j
%             H(j,i) = H(j,i) + L(i);
%         end
    end
end
Hessian = H;

