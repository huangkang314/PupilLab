function data_epoch = op_epoch(data,point)
% ����������ݰ���point������ȡ���ֳɲ�ͬ�Ķ�
num = floor(numel(data)/point);
data_epoch = zeros(num,point);
for i = 1:num
    data_epoch(i,:) = data((i-1)*point +1 :i*point);
end