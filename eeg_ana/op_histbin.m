function h = op_histbin(data)
% ����hist bin �Ĵ�С ������̬
data(isnan(data)) = [];
n = numel(data);
h = 3.5*std(data)*n^(-1/3);
end