function op_plot_varCloudEx(data,xx,threshold,color,ylabel_str,legend_str)
% 画带 +- sem 的图,
% 输入的data1 为 trial * timelong，先根据每一个点计算一个sem,然后画出带sem的图
%%

transparency = 0.35;
fstart = find(xx > threshold(1),1,'first');
fend = find(xx < threshold(2),1,'last');
xx = xx(fstart:fend);
figure
hold on

Numdata = numel(data);
h = zeros(1,Numdata);
for i = 1:Numdata
    data1 = data{i};
    data1 = data1(:,fstart:fend);
    long = size(data1,2);
    data_sem = zeros(1,long);
    for j = 1 : long
        data_sem(j) = sem(data1(:,j));
    end
    data_mean = mean(data1);
    
    X = [xx fliplr(xx)];
    Y = [data_mean + data_sem, fliplr(data_mean - data_sem)];
    patch(X,Y,color{i}, 'FaceAlpha', (1-transparency), 'LineStyle', 'none' );
    h(i) = plot(xx, data_mean, 'Color', color{i}, 'LineWidth', 2);
     hold on
     [~, pos] = max(data_mean);
    plot(xx(pos),data_mean(pos),'^','markersize',16,'markeredgecolor',color{i})
end


if Numdata == 2
%     h_legend = legend(h,{'Baseline','Sti'},'location','northwest');
    h_legend = legend(h,legend_str,'location','northeast');
else
    h_legend = legend(h,{'Baseline','After KA','Sti'},'location','northwest');
end

% 在data_mean最大的地方打上个标志





legend('boxoff');
set(h_legend,'Fontsize',14)
% xlabel('Frequency [Hz]','Fontsize',20)
xlabel('Lags [ms]','Fontsize',20)
ylabel(ylabel_str,'Fontsize',20)
set(gca,'linewidth',3,'Fontsize',20,'tickdir','out')
set(gcf,'color',[1 1 1])
ylim([0 1]);
% xlim([10 100])

end