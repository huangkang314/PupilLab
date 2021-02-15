function p_value = op_shuffpvalue(pool,data)
% 计算一个点在整个pool中的概率值
x = min(pool) :((max(pool)-min(pool))/1000): max(pool);
pool = sort(pool);
n_elements = histc(pool,x);
c_elements = cumsum(n_elements);
c_elements = c_elements/numel(pool);
pos = find(data < x,1,'first');
if isempty(pos)
    pos = find(data > x,1,'last');
end

p_value = c_elements(pos);
% if p_value >.95
%     p_value = 1 - p_value;
% end

    
    



