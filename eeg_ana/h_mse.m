function out = h_mse(data)
Num = size(data,2);
out = zeros(1,Num);
for i = 1 : Num
    data1 = data(:, i);
    data1(isnan(data1)) = [];
    data1(isinf(data1)) = [];
    out(i) = sem(data1);
end
