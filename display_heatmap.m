function h = display_heatmap(ICs_1, ICs_cmp, filename, ...
    x_char, y_char, position)
% IC_1:   n_ICs_1   * N
% IC_cmp: n_ICs_cmp * N

n_ICs_1   = size(ICs_1,   1);
n_ICs_cmp = size(ICs_cmp, 1);

D = zeros(n_ICs_1, n_ICs_cmp);

for ii = 1 : n_ICs_1
    for jj = 1 : n_ICs_cmp
        D(ii, jj) = cal_dis(ICs_1(ii, :), ICs_cmp(jj, :));
    end
end

fs = 20;

xvalues = {};
for ii = 1 : n_ICs_cmp
    xvalues{ii} = ['\it {\bf ', x_char, '}_{', ...
        num2str(ii), '}'];
end
yvalues = {};
for ii = 1 : n_ICs_1
    yvalues{ii} = ['\it {\bf ', y_char, '}_{', ...
        num2str(ii), '}'];
end
f = figure;
if nargin == 6
    f.Position = position;
end

h = heatmap(xvalues, yvalues, D, 'ColorLimits', [0 20]);
h.CellLabelFormat = '%0.3g';
set(gca, 'FontSize', fs)
set(gcf, 'PaperPositionMode', 'auto')
print('-depsc', filename);
