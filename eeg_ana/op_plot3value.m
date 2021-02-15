function op_plot3value(Meanvalue,Varvalue,Pvalue,title_str,ylabel_str,xticklabel_str)
%Meanvalue = [1.14;1.42];
hdg = bar(Meanvalue,'barwidth',0.6,'linewidth',1.5);
xlim([0 4]);colormap gray;ylim(ylim*1.3);hold on
ylabel(ylabel_str,'Fontsize',15);title(title_str,'Fontsize',15)
set(gca,'xticklabel',xticklabel_str,'fontsize',15,'linewidth',2,'tickdir','out')    
%set(hl,'location','northeast')
hold on
%set(get(hdg(1),'BaseLine'),'LineWidth',2,'LineStyle',':')
x = get(get(hdg(1),'children'), 'xdata');
x_mid = mean(x([1 3],:));
x_line = x([1 3],:);
%     handle_error_one=errorbar(x, data_mean(:,i_barnumber), data_std(:,i_barnumber), 'k', 'linestyle', 'none',...
%         'markersize',1);
for i_x = 1:length(x_mid)
    line([x_mid(i_x) x_mid(i_x)],[Meanvalue(i_x),Meanvalue(i_x)+Varvalue(i_x)],'Color','k','linewidth',2)
    line([x_line(1,i_x)+0.2,x_line(2,i_x)-0.2],[Meanvalue(i_x)+Varvalue(i_x),Meanvalue(i_x)+Varvalue(i_x)],'Color','k','linewidth',2)
end

ybegin = Meanvalue+Varvalue;
starin = 0.1;
if Pvalue.a == 1
        text(x_mid(1)-.06,ybegin(1)+ybegin(1)*starin,'*','Fontsize',30,'color','k','linewidth',2);
end
if Pvalue.b == 1
        text(x_mid(2)-.06,ybegin(2)+ybegin(2)*starin,'*','Fontsize',30,'color','k','linewidth',2);
end
if Pvalue.c == 1
        text(x_mid(3)-.06,ybegin(3)+ybegin(3)*starin,'*','Fontsize',30,'color','k','linewidth',2);
end

set(gcf,'color',[1 1 1]);box off
end