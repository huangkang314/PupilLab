function [ resampleData ] = resample(data, oldSR, newSR)
data_len = size(data, 1);
oldtime = linspace(1/oldSR, data_len/oldSR, data_len);

re_ratio = round(newSR/oldSR);

new_time = linspace(1/newSR, re_ratio*data_len/oldSR, re_ratio*data_len);
new_time = new_time';
% monotonically increasing
while ~all(diff(oldtime)>0)
    oldtime(find(diff(oldtime) <= 0)+1) = oldtime(find(diff(oldtime) <= 0)+1) + 0.000001;
end

resampleData = interp1(oldtime, data, new_time, 'nearest');
resampleData = fillmissing(resampleData, 'nearest');

end

