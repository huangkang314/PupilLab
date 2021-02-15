function op_plot2axis(method1,method2,xx,data1,data2)
% 两个坐标轴画图，第一个画图方法用method1,第二个画图方法用method2
ax1 = axes('xlim',[min(xx) max(xx)]);hold on
feval(method1,xx,data1,.9,'facecolor','k')
set(ax1,'ylim',[0,15],'ytick',[0 3 6 9 12 15],'linewidth',2,'Fontsize',18,'tickdir','out')
xlabel('EPM score')
set(get(ax1,'YLabel'),'String','Number of cells','Fontsize',18)
set(get(ax1,'XLabel'),'String','EPM score','Fontsize',18)
set(gcf,'color',[1 1 1])

ax2 = axes('position',[0.1300    0.11    0.7750    .8150],'yaxislocation','right','color','none','xlim',[min(xx) max(xx)]);
hold on
feval(method2,xx,data2,'r','linewidth',2)
set(ax2,'ylim',[0,.3],'ytick',[0 .1 .2 .3],'linewidth',2,'Fontsize',18,'tickdir','out','ycolor','r')
set(get(ax2,'YLabel'),'String','Probability density ','Fontsize',18,'rotation',270,'position',[1.23 .15 16])

end