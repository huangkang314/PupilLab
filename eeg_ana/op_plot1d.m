function op_plot1d(t,data,ylabel_str,xlabel_str,ya)
% »­1Î¬Êý¾Ý
plot(t,data,'linewidth',1.5,'color','k');ylim(ya);
% line([min(t),max(t)],[0 0],'line','--','linewidth',2,'color',[.6 .6 .6])
ylabel(ylabel_str,'Fontsize',20);xlabel(xlabel_str,'Fontsize',20)
set(gca,'ytick',ya,'Fontsize',20,'linewidth',2,'box','off');
set(gcf,'color','w')
end