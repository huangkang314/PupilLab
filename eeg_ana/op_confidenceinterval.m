function result = op_confidenceinterval(data,bin,alpha)
% �����������䣬������������ m*n �ľ��������ÿһ�е���������,
% ������Ϊһ�������������������������������
n = size(data,2);
x = min(min(data)) : bin : max(max(data));
result = zeros(3,n);
for i = 1:n
    data1 = data(:,i);data1 = sort(data1);
    n_elements = histc(data1,x);
    c_elements = cumsum(n_elements);
    c_elements = c_elements/numel(data1);
    confidence_low = x(find(c_elements < alpha/2,1,'last'));
    if isempty(confidence_low)
        confidence_low = min(x) ;
    end
    confidence_high = x(find(c_elements >= 1 - alpha/2,1,'first'));
    if isempty(confidence_high)
        confidence_high = max(x);
    end
    pp = n_elements/sum(n_elements);
    mean_value = x * pp;
    result(:,i) = [confidence_low,mean_value,confidence_high];
end
result = mean(result,2);