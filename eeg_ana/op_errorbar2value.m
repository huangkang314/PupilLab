function op_errorbar2value(tt,meanvalue,semvalue,marker,color,h_value,lim,xlabel_str,ylabel_str,title_str)

figure;hold on
errorbar(tt,meanvalue(1,:),semvalue(1,:),'Marker',marker{1},'color',color{1},'linestyle','--','linewidth',1.5,'MarkerSize',12);
errorbar(tt,meanvalue(2,:),semvalue(2,:),'Marker',marker{2},'color',color{1},'linestyle','--','linewidth',1.5,'MarkerSize',12);
h_legend = legend('control group','stimulation group');
set(h_legend,'box','off','location','NorthWest')
xlim(lim(1:2));ylim(lim(3:4));

xlabel(xlabel_str);ylabel(ylabel_str);title(title_str);
set(gca,'xtick',[tt,lim(2)]);
op_setfigpar(gca)

value = meanvalue + semvalue;
for i = 1 : numel(h_value)
    h_value1 = h_value(i);
    if h_value1 == 1
        plot(tt(i),max(value(:,i))+1,'k*','markersize',8)
    end
end