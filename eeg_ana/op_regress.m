function [statsout,index]  = op_regress(data1,data2,color,outlier,ylabel_str, xlabel_str,title_str,boundx,boundy,pos)
% 回归分析 所有数据都进行回归分析

X = [ones(size(data1)) data1];
[b,~,~,rint,stats] = regress(data2,X);

index = find(rint(:,1).*rint(:,2) > 0);
if outlier == 1
    data1(index,:) = [];
    data2(index,:) = [];
    X = [ones(size(data1)) data1];
    [b,~,~,~,stats] = regress(data2,X);
end

if nargin == 7
    boundx(1) = child_bound(min(data1));
    boundx(2) = child_bound(max(data1));
    boundy(1) = child_bound(min(data2));
    boundy(2) = child_bound(max(data2));
    xx = boundx(1) : boundx(2);
else
    xx = boundx(1) : .0001 : boundx(2);
end

yy = b(2)*xx + b(1);

plot(data1,data2,'o','color',color,'MarkerSize',8,'markerfacecolor',color)
hold on
plot(xx,yy,'color',color,'linewidth',3)

axis([boundx,boundy])
statsout = stats([1 3]);
statsout(1) = sign(b(2)) * sqrt(statsout(1));

statsout(3) = numel(data1);
set(gcf,'color',[1 1 1]);
set(gca,'fontsize',25,'linewidth',2)
ylabel(ylabel_str,'Fontsize',25)
xlabel(xlabel_str,'Fontsize',25)
title(title_str,'Fontsize',25)
box off

str_1 = [' r ^{2}= ',num2str(roundn(statsout(1),-2))];
if statsout(2) < .05 && statsout(2) > .0001
    str_2 = ['p = ',num2str(roundn(statsout(2),-4))];
elseif statsout(2) < .0001
    str_2 = 'p < .0001';
else
    str_2 =[  'p = ',num2str(roundn(statsout(2),-4))];
end

text(pos(1,1),pos(1,2), str_1, 'Fontsize', 25)
text(pos(2,1),pos(2,2) ,str_2, 'Fontsize', 25)


end

function dataout = child_bound(data)
bit = floor(log10(abs(data)));
if data > 0
    dataout = floor(data/10^bit);
    dataout = 10^bit*(dataout + 1);
elseif data < 0
    dataout = floor(abs(data)/10^bit);
    dataout = -10^bit*(dataout + 1);
else
    dataout = 0;
end
end
