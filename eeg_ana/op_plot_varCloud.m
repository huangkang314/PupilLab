function op_plot_varCloud(data,err,xx,color,threshold,ylabel_str,xlabel_str,legend_str,ylimvalue)
% 画带 +- sem 的图,
% 输入的data1 为 trial * timelong，先根据每一个点计算一个sem,然后画出带sem的图

transparency = 0.55;
if ~isempty(threshold)
    fstart = find(xx >= threshold(1),1,'first');
    fend = find(xx <= threshold(2),1,'last');
    xx = xx(fstart:fend);
    data = data(:,fstart:fend);
    err = err(:,fstart:fend);
end

figure
hold on
h = zeros(1,2);
numWaves = size(data,1);
for i = 1 : numWaves
    h(i) = plot(xx, data(i,:), 'Color', color{i}, 'LineWidth', 2.5);
    X = [xx fliplr(xx)];
    Y = [data(i,:) + err(i,:), fliplr(data(i,:) - err(i,:))];
    patch(X,Y,color{i}, 'FaceAlpha', (1-transparency), 'LineStyle', 'none' );
end
% legend(h,{legend_str{1},legend_str{2}},'location','Best');
% h_legend = legend(h,legend_str,'location','Best');
% ylim([0 40])
% 
% legend('boxoff');
% set(h_legend,'Fontsize',25,'Fontname','Arial')
xlabel(xlabel_str,'Fontsize',35,'Fontname','Arial')
ylabel(ylabel_str,'Fontsize',35,'Fontname','Arial')
% xtick('Fontsize',40,'Fontname','Arial')
% ytick('Fontsize',40,'Fontname','Arial')
op_setfigpar(gca)
% xlim([-202 200])
% aa = ylim;
% if abs(aa) < .1
%     ylim([-.1 .1])
% end

end