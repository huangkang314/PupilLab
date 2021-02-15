function [align_eeg, align_pupil, time_eegAli, time_pupilAli, fs_eeg] = load_eeg_pupil(eeg_name, pupil_name)

fs_pupil =200;

align_eeg = load(pupil_name);

pupil_fuse = align_eeg.exp02fuse.raw.rawdata;
data_len = length(pupil_fuse);
time_pupil = linspace(0, data_len/fs_pupil, data_len);

%%

[hdr, eeg]  = edfread(eeg_name);

chl_names = hdr.label;
n_chl = length(chl_names) - 1;

i_ch = 1;
fs_eeg = hdr.frequency(i_ch);
eeg_len = size(eeg, 2);
time_eeg = linspace(0, eeg_len/fs_eeg, eeg_len);

start_offset = 97*fs_eeg;
align_eeg = eeg(:, start_offset:end);
align_len = size(align_eeg, 2);
time_eegAli = linspace(0, align_len/fs_eeg, align_len);

end_offset = round((time_pupil(end) - time_eegAli(end))*fs_pupil);

align_pupil = pupil_fuse(:, 1:end-end_offset);
align_lenPupil = size(align_pupil, 2);
time_pupilAli = linspace(0, align_lenPupil/fs_pupil, align_lenPupil);

align_pupil = interp1(time_pupilAli, align_pupil, time_eegAli, 'nearest');
align_pupil = fillmissing(align_pupil, 'nearest');


