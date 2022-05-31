function display_ICs(ICs, filename, ylabel_char)
% ICs:   n_ICs * N

if nargin == 1
    figure
    n_ICs = size(ICs, 1);
    for jj = 1 : n_ICs
        subplot(n_ICs, 1, jj);
        plot(ICs(jj, :))
    end
else
    figure
    n_ICs = size(ICs, 1);
    for jj = 1 : n_ICs
        subplot(n_ICs, 1, jj);
        plot(ICs(jj, :))
        ylabel(['\it {\bf ', ylabel_char, '}_{', ...
            num2str(jj), '}'], ...
            'Interpreter', 'tex')
        set(gca, 'YTickLabel', [])
        set(gca,'FontSize',15)
        if jj ~= n_ICs
            set(gca, 'XTickLabel', [])
            set(gca,'FontSize',15)
            grid on
        end
    end
    print('-depsc', filename);
end
