function dataout = op_randselectinData(datain,number)
% datain����Ϊһ������������һ�������������������ѡȡ number ��ֵ�����Ż�ѡȡ
% number < numel��datain��

Num = size(datain,1);
if Num < number
    dataout = [];
    disp('�������ݳ���С��Ҫѡȡ����')
    return;
end

p = randperm(Num);
dataout = datain(p(1:number),:);

end