function op_plotbar(Meanvalue,Varvalue,Pvalue,ylabel_str,title_str,iic)
xx = -60:10:300-10;
hdg = bar(xx,Meanvalue,'barwidth',0.9,'linewidth',1.5);
xlim([-70 300]);%colormap summer;
hBaseline = get(hdg(1),'BaseLine');
set(hBaseline,'linewidth',1.5)
ylabel(ylabel_str,'Fontsize',15);
title(title_str,'Fontsize',15);
%set(hl,'location','northeast')
set(gca,'fontsize',15,'linewidth',2,'box','off','xtick',[-60 0 60 120 180 240 300])

hold on
%errorbar([0.727 0.9078 1.0913 1.2727;1.7284 1.9071  2.0913 2.2741],dg,dge,'b','linestyle','none')
%set(get(hdg(1),'BaseLine'),'LineWidth',2,'LineStyle',':')
x = get(get(hdg(1),'children'), 'xdata');
x_mid = mean(x([1 3],:));
x_line = x([1 3],:);
%     handle_error_one=errorbar(x, data_mean(:,i_barnumber), data_std(:,i_barnumber), 'k', 'linestyle', 'none',...
%         'markersize',1);
for i_x = 1:length(x_mid)
    if Meanvalue(i_x) > 0
    line([x_mid(i_x) x_mid(i_x)],[Meanvalue(i_x),Meanvalue(i_x)+Varvalue(i_x)],'Color','k','linewidth',2)
    line([x_line(1,i_x)+0.2,x_line(2,i_x)-0.2],[Meanvalue(i_x)+Varvalue(i_x),Meanvalue(i_x)+Varvalue(i_x)],'Color','k','linewidth',2)
    else 
    line([x_mid(i_x) x_mid(i_x)],[Meanvalue(i_x),Meanvalue(i_x)-Varvalue(i_x)],'Color','k','linewidth',2)
    line([x_line(1,i_x)+0.2,x_line(2,i_x)-0.2],[Meanvalue(i_x)-Varvalue(i_x),Meanvalue(i_x)-Varvalue(i_x)],'Color','k','linewidth',2)    
    end
    
    if Pvalue(i_x) == 1
        if Meanvalue(i_x) > 0
        plot(x_line(1,i_x)+4,Meanvalue(i_x)+Varvalue(i_x)+iic,'*','Color','k')
        else
        plot(x_line(1,i_x)+4,Meanvalue(i_x)-Varvalue(i_x)-iic,'*','Color','k')
        end
    end
    
    
end
set(gcf,'color',[1 1 1])
ylim([-1.5 12])


