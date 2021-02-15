
clear all
% input data name
data_name = '02.edf';

[hdr, data]  = edfread(data_name);

chl_names = hdr.label;
n_chl = length(chl_names) - 1;

%%
figure
set(gcf, 'Position', [100, 300, 1600, 400])
for i_ch = 1:n_chl
    data_chl = data(i_ch, :);
    fs = hdr.frequency(i_ch);
   	subplot(3, 1, i_ch)
    pspectrum(data_chl, fs, 'spectrogram', 'FrequencyResolution', 10,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 80], 'MinTHreshold',-30);
    title(chl_names(i_ch))
end
