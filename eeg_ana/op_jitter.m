function anospikes = op_jitter(timestamp,jitterrange,jitterbin)
% ����ԭ���� timestamp ���丽��jitter���µ�timestamp
% jitterrange Ϊjitter�ķ�Χ
% jitterbin Ϊÿ��jitter�ķ�Χ

% ����jitter��bin����0-jitterrange������
anospikes = zeros(1,numel(timestamp));
numbin = jitterrange/jitterbin;

%******** ����ÿһ��spike ���ѡ��jitter��bin��******
for i_spike = 1:numel(timestamp)
%     i1 = randi([min(numbin) : -1 ,1 : max(numbin)],1);
    pool = [min(numbin) : -1 ,1 : max(numbin)];
    i1 = randperm(numel(pool));
    i1 = pool(i1(1));
    ts = timestamp(i_spike);
    tsnew = ts + i1*jitterbin;
    anospikes(i_spike) = tsnew;
end
