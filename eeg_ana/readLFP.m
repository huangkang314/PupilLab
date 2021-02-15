function [adfreqs, LFP] = readLFP(data_name)

[~, ~, ~, slowcounts] = plx_info(data_name, 1);

% get the a/d data.
[nad, adfreqs] = plx_adchan_freqs(data_name);
[~, adnames] = plx_adchan_names(data_name);


lfpIdx = [];
for ich = 1:nad
    tem_adname = adnames(ich, :);
    if ~(contains(tem_adname, 'FP') && slowcounts(ich) ~= 0)
    else
        lfpIdx = [lfpIdx, ich];
    end
end

nlfp = length(lfpIdx);
LFP = [];
for ifp = 1:nlfp
    tem_ch = lfpIdx(ifp);
    [~, ~, ~, ~, LFP(ifp).data] = plx_ad(data_name, tem_ch-1);
    LFP(ifp).name = adnames(tem_ch, :);
    
end

adfreqs = adfreqs(lfpIdx(1));