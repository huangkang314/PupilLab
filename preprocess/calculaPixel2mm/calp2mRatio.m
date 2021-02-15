function ratio = calp2mRatio(dlcFileName, isegName)

warning('off')
% load DLC data
lhThr = 0.8;
% pixel2mm_ratio = 1/55.35;
pupil_dlcRaw = extractPupil_dlc(dlcFileName, lhThr, 'average');
% pupil_dlc = pupil_dlcRaw'*pixel2mm_ratio; % trans pixel to mm

% load eFile data
seg_data = importdata(isegName); % efile is the saved data during online recording
pupil_segRaw = seg_data(:,end);

% show raw data and select ratio
figure
plot(zscore(pupil_dlcRaw))
hold on
plot(zscore(pupil_segRaw))
roi = drawrectangle;

pdlc_select = pupil_dlcRaw(roi.Position(1): roi.Position(1)+roi.Position(3));
pseg_select = pupil_segRaw(roi.Position(1): roi.Position(1)+roi.Position(3));
ratio = mean(pdlc_select./pseg_select);


% normalize
% pupil_dlc = zscore(pupil_dlcRaw');
% pupil_seg = zscore(pupil_segRaw);
% figure
% plot(pupil_dlc)
% hold on
% plot(pupil_seg)

