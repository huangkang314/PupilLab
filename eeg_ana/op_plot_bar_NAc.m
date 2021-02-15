function op_plot_bar_NAc(xx,Meanvalue,semvalue,color,xlabel_str,ylabel_str,title_str,ylim)

hdg = bar(xx,Meanvalue,'barwidth',0.9,'linewidth',1.5,'facecolor',color);
hBaseline = get(hdg(1),'BaseLine');
set(hBaseline,'linewidth',1.5)
ylabel(ylabel_str,'Fontsize',30);
title(title_str,'Fontsize',30);
%set(hl,'location','northeast')
set(gca,'fontsize',30,'linewidth',2,'box','off','xtick',[-5 -4 -3 -2 -1 0 1 2 3 4 5],'ylim',ylim,'xlim',[-5.4 5.4],'tickdir','out')

hold on
x = get(get(hdg(1),'children'), 'xdata');
x_mid = mean(x([1 3],:));
x_line = x([1 3],:);
for i_x = 1:length(x_mid)
    if Meanvalue(i_x) > 0
    line([x_mid(i_x) x_mid(i_x)],[Meanvalue(i_x),Meanvalue(i_x)+semvalue(i_x)],'Color','k','linewidth',2)
    line([x_line(1,i_x)+0.2,x_line(2,i_x)-0.2],[Meanvalue(i_x)+semvalue(i_x),Meanvalue(i_x)+semvalue(i_x)],'Color','k','linewidth',2)
    else 
    line([x_mid(i_x) x_mid(i_x)],[Meanvalue(i_x),Meanvalue(i_x)-semvalue(i_x)],'Color','k','linewidth',2)
    line([x_line(1,i_x)+0.2,x_line(2,i_x)-0.2],[Meanvalue(i_x)-semvalue(i_x),Meanvalue(i_x)-semvalue(i_x)],'Color','k','linewidth',2)    
    end
end
set(gcf,'color',[1 1 1])



