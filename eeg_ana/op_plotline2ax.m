function op_plotline2ax(xx1,data1,xx2,data2)
% 画两个坐标轴的图，图中数据在不同的轴的相应位置对应

ax1 = axes('xlim',[min(xx1) 10]);
feval(@plot,xx1,data1,'k','linewidth',1)
set(ax1,'ylim',[-1, 1],'ytick',[-1 0 1],'linewidth',1.5,'Fontsize',18,'tickdir','out','box','off')
xlabel('Time [s]')
set(get(ax1,'YLabel'),'String','Amplitude [mV]','Fontsize',18)
set(gcf,'color',[1 1 1])
% op_setfigpar(gca);
set(gca,'position',[.1 .12 .8 .35])
% axis tight

ax2 = axes('position',[.1 .6 .8 .35],'xlim',[0 10]);
feval(@plot,xx2,data2,'k','linewidth',1)
set(ax2,'ylim',[-.1,.1],'ytick',[-.1 0 .1],'linewidth',2,'Fontsize',18,'tickdir','out','box','off')
set(get(ax2,'YLabel'),'String','Amplitude [mV]','Fontsize',18)
% op_setfigpar(gca);
% axis tight

end