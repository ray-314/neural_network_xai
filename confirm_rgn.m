


filename = 'NN1_2_';

J = 2;

A = zeros(5);
for ii = 1 : 5
    load([filename, num2str(ii), '_old.mat'])
    H_old = H;
    for jj = 1 : 5
        load([filename, num2str(jj), '.mat'])
        A(ii, jj) = all(H(:) == H_old(:));
    end
end



