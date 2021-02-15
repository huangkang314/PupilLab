function data = op_normalref(data,t,t_ref)
pos1 = find(t > t_ref.before,1,'first');
pos2 = find(t < t_ref.end,1,'last');
data=data';
meanval = nanmean(data(pos1 : pos2,:),1);
data = (data -  repmat(meanval,size(data,1),1))./repmat(meanval,size(data,1),1);
data=data';
% if max(max(data)) > 20
%     data = zeros(size(data));
% end
% data = op_normal(data);
end