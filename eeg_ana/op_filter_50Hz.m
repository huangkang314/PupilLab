function filtered_data = op_filter_50Hz(data)
% �˳�50Hz�źŵĸ���
% data��ÿһ��Ϊһ���źţ���ÿһ�е����ݽ����˲�
load('filter50Hz.mat')

filtered_data = zeros(size(data,1),size(data,2));

for i = 1 : size(data,1)
    filtered_data(i,:) = filtfilt(Hd.sosMatrix,Hd.ScaleValues,data(i,:));
end