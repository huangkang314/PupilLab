function dataout = op_randselectinData(datain,number)
% datain输入为一个行向量或者一个列向量，从其中随机选取 number 个值，不放回选取
% number < numel（datain）

Num = size(datain,1);
if Num < number
    dataout = [];
    disp('输入数据长度小于要选取长度')
    return;
end

p = randperm(Num);
dataout = datain(p(1:number),:);

end