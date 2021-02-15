function op_GetLFP(path,chan)

filename = path;

[Fs,~,tsLFP,~,LFP] = plx_ad_v(filename,chan);  % algin 之后的文件
addpoint = zeros(round(tsLFP * Fs),1);
if ~isempty(addpoint)
    LFP = cat(1,addpoint,LFP);
end

event = ReadEvent(filename,32);
data.LFP = LFP;
data.event = event;

save([path(1:end-4),'.mat'],'data')
