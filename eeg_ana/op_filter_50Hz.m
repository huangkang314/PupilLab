function filtered_data = op_filter_50Hz(data)
% 滤除50Hz信号的干扰
% data中每一行为一个信号，对每一行的数据进行滤波
load('filter50Hz.mat')

filtered_data = zeros(size(data,1),size(data,2));

for i = 1 : size(data,1)
    filtered_data(i,:) = filtfilt(Hd.sosMatrix,Hd.ScaleValues,data(i,:));
end