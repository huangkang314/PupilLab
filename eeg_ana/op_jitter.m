function anospikes = op_jitter(timestamp,jitterrange,jitterbin)
% 根据原来的 timestamp 在其附近jitter出新的timestamp
% jitterrange 为jitter的范围
% jitterbin 为每次jitter的范围

% 可以jitter的bin，从0-jitterrange的区间
anospikes = zeros(1,numel(timestamp));
numbin = jitterrange/jitterbin;

%******** 对于每一个spike 随机选择jitter的bin　******
for i_spike = 1:numel(timestamp)
%     i1 = randi([min(numbin) : -1 ,1 : max(numbin)],1);
    pool = [min(numbin) : -1 ,1 : max(numbin)];
    i1 = randperm(numel(pool));
    i1 = pool(i1(1));
    ts = timestamp(i_spike);
    tsnew = ts + i1*jitterbin;
    anospikes(i_spike) = tsnew;
end
