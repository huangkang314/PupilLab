function flag = op_variance_delete(data, m, n)
% 在数据中寻找data中存在n个大于m * SD 的点
SD = std(data);
num = find(data > m*SD);
if numel(num) > n
    flag = true;
else
    flag = false;
end

end