function op_setfigpar(ax)
if nargin == 1
    gca = ax;
end
% h_ylabel = get(gca,'Ylabel');
% h_xlabel = get(gca,'Xlabel');
% h_title = get(gca,'title');
% set(h_ylabel,'Fontsize',20)
% set(h_xlabel,'Fontsize',20)
% set(h_title,'Fontsize',20)
set(gcf,'color',[1 1 1])
set(gca,'fontsize',35,'fontname','Arial','linewidth',3,'box','off','TickDir','out','TickLength',[0.012 0.025])
end




