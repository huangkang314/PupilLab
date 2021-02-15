function h = op_histbin(data)
% 计算hist bin 的大小 假设正态
data(isnan(data)) = [];
n = numel(data);
h = 3.5*std(data)*n^(-1/3);
end