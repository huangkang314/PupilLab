function anospikes = op_shuffleisi(allspikes,event,timespan)
% 输入为timestamp
% 根据原来的 timestamp 产生一个新的 timestamp， interspike interval 保持不变
% 如果输入为单一变量，则直接shuffle，保持interspike interval不变
% 如果输入为三个变量，则shuffle event 时刻周围的timespan的timestamp
% 时间单位秒
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
%******* 先计算interspike interval
inters = diff(allspikes);
%******** then make a random permutation   随机排******
mo = numel(inters);
rr = randperm(mo);

%********** and write back in different order
lastspike = 0;
for tt = 1:(mo-1)
    lastspike = inters(rr(tt)) + lastspike;
    anospikes(tt) = lastspike;
end

end
