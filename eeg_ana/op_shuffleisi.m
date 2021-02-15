function anospikes = op_shuffleisi(allspikes,event,timespan)
% ����Ϊtimestamp
% ����ԭ���� timestamp ����һ���µ� timestamp�� interspike interval ���ֲ���
% �������Ϊ��һ��������ֱ��shuffle������interspike interval����
% �������Ϊ������������shuffle event ʱ����Χ��timespan��timestamp
% ʱ�䵥λ��
if nargin == 1
    anospikes = child_shuff(allspikes);
else
    anospikes = allspikes; 
    jitterbin = .005;
    c = 0;
    for i_event = 1 : numel(event)
          event1 = event(i_event);
          spkind = (anospikes >= event1 + timespan(1)) & (anospikes <= event1 + timespan(2));
          if sum(spkind) > 0
             spkshuff = anospikes(spkind);
             jitterspk = op_jitter(spkshuff,timespan,jitterbin);     
             anospikes(spkind) = jitterspk;
             c  = c+1;
          end
    end
    anospikes = sort(anospikes);
end

end

function anospikes = child_shuff(allspikes)

anospikes = zeros(1,numel(allspikes)-1);
%******* �ȼ���interspike interval
inters = diff(allspikes);
%******** then make a random permutation   �����******
mo = numel(inters);
rr = randperm(mo);

%********** and write back in different order
lastspike = 0;
for tt = 1:(mo-1)
    lastspike = inters(rr(tt)) + lastspike;
    anospikes(tt) = lastspike;
end

end
