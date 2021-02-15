function [x,y,C_data] = op_getfig_x_y(name)
% name为.fig 文件名字，按照name打开.fig文件，获取x轴和y轴坐标，返回

a = 2;   % 因为每一个图片画的不一样，所以设定提取figure 中的child 句柄
b = 4;

h=openfig(name,'new');  % get the information of the plot of the data
h_a=get(h,'Children');
h_line=get(h_a,'Children');
x=get(h_line{a}(b),'Xdata');
y=get(h_line{a}(b),'Ydata');
C_data=get(h_line,'Cdata');

