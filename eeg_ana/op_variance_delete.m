function flag = op_variance_delete(data, m, n)
% ��������Ѱ��data�д���n������m * SD �ĵ�
SD = std(data);
num = find(data > m*SD);
if numel(num) > n
    flag = true;
else
    flag = false;
end

end