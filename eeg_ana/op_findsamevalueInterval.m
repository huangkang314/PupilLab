function [start,long] = op_findsamevalueInterval(point, findvalue)
% �ҵ�������Ϊ findvalue ֵ��Ƭ��
% long Ϊ��������Ϊfindvalue ֵƬ�εĳ���
% start Ϊ��������Ϊfindvalue ֵƬ�ε���ʼ��
% ���Է���Ϊ findvalue ֵ����󳤶�Ϊ [~��I] = max��long��
% ��ʼλ��Ϊ start(I)
Num = numel(point);
long = [];
start = [];
cc = 0;
for i = 1 : Num              % �ӵ�һ���㿪ʼ
    point1 = point(i);      
    if point1 < findvalue           % ���һ���� == findvalue   
        cc = cc + 1;            %������ +1
        
        if i == length(point) || point(i+1) > findvalue    % ���������������������һ���� ����������һ���� ~= findvalue
            long = [long;cc];cc = 0;                                    % �����Ƭ�ν�����cc ����
        end 
        
        if i == 1 || point(i-1) > findvalue                        % ���������ǵ�һ���������֮ǰ�ĵ� ~= findvalue ��һ����Ƭ�ο�ʼ
            start = [start;i];
        end   
    end
    
end
[maxlong,I] = max(long);
 startpoint = start(I);
