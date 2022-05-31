clear
close all

[X_no_cnstnt, Y] = data_for_NN1_exp1;
for J = 1 : 10
    for seed = 1 : 5
        fprintf("J = %d, seed = %d\n", J, seed)
        start_learning(X_no_cnstnt, Y, J, seed, ...
            'learned_NNs/NN1_exp1_');
    end
end

