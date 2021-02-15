function [start,long] = op_findsamevalueInterval(point, findvalue)
% 找到序列中为 findvalue 值的片段
% long 为所有连续为findvalue 值片段的长度
% start 为所有连续为findvalue 值片段的起始点
% 所以返回为 findvalue 值的最大长度为 [~，I] = max（long）
% 起始位置为 start(I)
Num = numel(point);
long = [];
start = [];
cc = 0;
for i = 1 : Num              % 从第一个点开始
    point1 = point(i);      
    if point1 < findvalue           % 如果一个点 == findvalue   
        cc = cc + 1;            %计数器 +1
        
        if i == length(point) || point(i+1) > findvalue    % 如果这个点是整个序列最后一个点 或者是它下一个点 ~= findvalue
            long = [long;cc];cc = 0;                                    % 则这个片段结束。cc 清零
        end 
        
        if i == 1 || point(i-1) > findvalue                        % 如果这个点是第一个点或者它之前的点 ~= findvalue 则一个新片段开始
            start = [start;i];
        end   
    end
    
end
[maxlong,I] = max(long);
 startpoint = start(I);
