function op_setfigcolorbar(ax,ylabel_str,pos)
if nargin > 1
    gca = ax;
end
set(ax,'fontsize',20,'linewidth',1.5,'box','on')
hylabel = ylabel(ax,ylabel_str,'rotation',270);
h_ylabel = get(ax,'Ylabel');
h_xlabel = get(ax,'Xlabel');
set(h_ylabel,'Fontsize',20)
set(h_xlabel,'Fontsize',20)
set(gcf,'color',[1 1 1])
pos = get(hylabel,'position');
set(hylabel,'position',[pos(1)+.4*pos(1),pos(2),pos(3)])

end
