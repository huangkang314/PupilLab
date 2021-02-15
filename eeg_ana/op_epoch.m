function data_epoch = op_epoch(data,point)
% 将输入的数据按照point个数截取，分成不同的段
num = floor(numel(data)/point);
data_epoch = zeros(num,point);
for i = 1:num
    data_epoch(i,:) = data((i-1)*point +1 :i*point);
end