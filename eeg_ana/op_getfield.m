function val = op_getfield(data,name)
% �Ӷ��cell�еĽṹ�ж�ȡ����
cellname = cell(size(data));
cellname(1:end)  = {name};
val = cellfun(@getfield,data,cellname, 'UniformOutput', false);
if ~ischar(val{1}) && numel(val{1}) == 1
    val = cell2mat(val);
end
end