function [x,y,C_data] = op_getfig_x_y(name)
% nameΪ.fig �ļ����֣�����name��.fig�ļ�����ȡx���y�����꣬����

a = 2;   % ��Ϊÿһ��ͼƬ���Ĳ�һ���������趨��ȡfigure �е�child ���
b = 4;

h=openfig(name,'new');  % get the information of the plot of the data
h_a=get(h,'Children');
h_line=get(h_a,'Children');
x=get(h_line{a}(b),'Xdata');
y=get(h_line{a}(b),'Ydata');
C_data=get(h_line,'Cdata');

