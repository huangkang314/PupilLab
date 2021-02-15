function data = op_normal(data)
maxdata = max(data,[],2);
mindata = min(data,[],2);
data = (data -  repmat(mindata,1,size(data,2)))./(repmat(maxdata,1,size(data,2)) - repmat(mindata,1,size(data,2)));
end