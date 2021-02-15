function [r, m, b] = plot_eeg_pupil_scatter(eeg, pupil)


[r, m, b] = regression(eeg, pupil);
scatter(eeg, pupil, 3,...
    'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none', 'LineWidth', 0.1)
hold on
yReg = m*eeg + b;
plot(eeg , yReg, 'Color', 'k')

L = legend(['R: ', num2str(r,'%4.2f')], ...
    'Color', 'none', 'Box', 'off', 'FontSize', 5);

set(gca, 'Color', 'none', 'TickDir', 'out',  'TickLength',[0.03, 0.03], 'Box', 'off', 'FontSize', 5)


% ylim([0, 1]); xlim([0, 1])
