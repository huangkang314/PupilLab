function statsout  = op_regress2(data1,data2,ind,ylabel_str, xlabel_str,title_str,leg,boundx,boundy,pos)
% 回归分析 所有部分数据都进行回归分析
data1_in = data1(ind);
data2_in = data2(ind);

data1_out = data1(~ind);
data2_out = data2(~ind);

X = [ones(size(data1_in)) data1_in];
[b_in,~,~,~,stats_in] = regress(data2_in,X);

X = [ones(size(data1_out)) data1_out];
[b_out,~,~,~,stats_out] = regress(data2_out,X);

xx = boundx(1) : boundx(2);

yy_in = b_in(2)*xx + b_in(1);
yy_out = b_out(2)* xx + b_out(1);

hold on
plot(data1_out,data2_out,'o','color',[.3 .3 .3],'markerfacecolor',[.8 .8 .8],'markersize',8,'linewidth',3)
plot(data1_in,data2_in,'o','color','k','markerfacecolor','k','markersize',8)
plot(xx,yy_in,'color','k','linewidth',2)
% plot(xx,yy_out,'color',[.5 .5 .5],'linewidth',2)

axis([boundx,boundy])
statsout.in = stats_in([1 3]); statsout.in(1) = sign(b_in(2)) * sqrt(statsout.in(1));
statsout.out = stats_out([1 3]); statsout.out(1) = sign(b_out(2)) * sqrt(statsout.out(1));

set(gcf,'color',[1 1 1]);
set(gca,'fontsize',20,'linewidth',2)
ylabel(ylabel_str,'Fontsize',20)
xlabel(xlabel_str,'Fontsize',20)
title(title_str,'Fontsize',20)
str_out = [' r = ',num2str(roundn(statsout.out(1),-2))];

if statsout.in(2) < .05 && statsout.in(2) > .0001
    str_in = [' r = ',num2str(roundn(statsout.in(1),-2))];
elseif statsout.in(2) < .0001
    str_in = [' r = ',num2str(roundn(statsout.in(1),-2))];
else
    str_in = [title_str,' r = ',num2str(roundn(statsout(1),-2)),' #'];
end

text(pos(1,1),pos(1,2), str_out, 'Fontsize', 18, 'color', [.5 .5 .5])
text(pos(2,1),pos(2,2) ,str_in, 'Fontsize', 18)
box off
if leg == 1
    legend('Other scores','Cell with scores > 0','location','northwest')
    legend boxoff
end

end


