function pupil = fuse_dlc_iseg(fs, dlcFileName, isegName, pixel2mm_ratio, show)

warning('off')
% load DLC data
lhThr = 0.8;

pupil_dlcRaw = extractPupil_dlc(dlcFileName, lhThr, 'average');
% pupil_dlc = pupil_dlcRaw'*pixel2mm_ratio; % trans pixel to mm

% load eFile data
seg_data = importdata(isegName); % efile is the saved data during online recording
pupil_segRaw = seg_data(:,end)';

pupil_dlc = pupil_dlcRaw'*pixel2mm_ratio;
pupil_seg = pupil_segRaw;


data_len = size(pupil_seg, 2);
time = linspace(0, data_len/fs, data_len);
%% Kalman paras

% State transition model
A = 1;

% Observation model
C1 = 1;
C2 = 1;
C = 1;
C_fuse = [C1; C2];

% Measurement noise covariances
R_dlc = std(pupil_dlc)^2;
R_seg = std(pupil_seg)^2;

% Process noise covariance
Q_dlc =std(pupil_dlc)/data_len;
Q_seg = std(pupil_seg)/data_len;
Q_fuse = data_len*std(pupil_dlc)*std(pupil_seg);

% Initialize
pupil_dlc_hat = zeros(1, data_len);
% pupil_dlc_hat(:, 1) = pupil_dlc(:, 1);
pupil_dlc_hat(:,1) = pupil_dlc(:,1);
pupil_seg_hat = zeros(1, data_len);
% pupil_e_hat(:, 1) = pupil_e(:, 1);
pupil_seg_hat(:,1) = pupil_seg(:,1);
pupil_fuse = zeros(1, data_len);
pupil_fuse(:, 1) = pupil_seg(:, 1);
% pupil_fuse(:,1) = C_fuse \ [pupil_dlc(:,1); pupil_e(:,1)];

% Initialize P, I
P_dlc = ones(size(A));
P_seg = ones(size(A));
P_fuse = ones(size(A));
err_dlc = zeros(data_len, 1);
err_dlc(1, :) = 0;
err_seg = zeros(data_len, 1);
err_seg(1, :) = 0;
I = eye(size(A));
G_fuse =  zeros(data_len, size(C_fuse, 1));
G_fuse(1, :) = [0, 1];


for i = 1:data_len-1
    
    % Predict
    pupil_dlc_hat(i+1) = A * pupil_dlc_hat(i);
    P_dlc = A * P_dlc * A' + Q_dlc;
    
    % Update
    G_dlc  = P_dlc  * C' / (C * P_dlc * C' + R_dlc);
    P_dlc  = (I - G_dlc * C) * P_dlc;
    pupil_dlc_hat(i+1) = pupil_dlc_hat(i+1) + G_dlc * (pupil_dlc(i+1) - C * pupil_dlc_hat(i+1));
    
    err_dlc(i+1, :) = data_len*abs(pupil_dlc_hat(i+1) - pupil_dlc(i+1))/(abs(pupil_dlc(i+1)) + eps);
    
    % Predict
    pupil_seg_hat(i+1) = A * pupil_seg_hat(i);
    P_seg = A * P_seg * A' + Q_seg;
    
    % Update
    G_seg  = P_seg  * C' / (C * P_seg * C' + R_seg);
    P_seg  = (I - G_seg * C) * P_seg;
    pupil_seg_hat(i+1) = pupil_seg_hat(i+1) + G_seg * (pupil_seg(i+1) - C * pupil_seg_hat(i+1));
    
    err_seg(i+1, :) = data_len*abs(pupil_seg_hat(i+1) - pupil_seg(i+1))/(abs(pupil_seg(i+1)) + eps);
    
    % Predict
    pupil_fuse(i+1) = A * pupil_fuse(i);
    P_fuse = A * P_fuse * A' + Q_fuse;
    
    % Update
    R_fuse = [err_dlc(i+1, :) 0; 0 err_seg(i+1, :)];
    G_fuse(i+1, :)  = P_fuse  * C_fuse' / (C_fuse * P_fuse * C_fuse' + R_fuse);
    P_fuse  = (I - G_fuse(i+1, :) * C_fuse) * P_fuse;
    pupil_fuse(i+1) = pupil_fuse(i+1) + G_fuse(i+1, :) * ([pupil_dlc(i+1); pupil_seg(i+1)] - C_fuse * pupil_fuse(i+1));
    
    
end


%%
if show

    %%
%     err_dlcnorm = (err_dlc - min(err_dlc)) / ( max(err_dlc) - min(err_dlc) );
%     err_segnorm = (err_seg- min(err_seg)) / ( max(err_seg) - min(err_seg) );

    noise_thr = -5;
    
    err_dlcnorm =mag2db(err_dlc/data_len);
    err_segnorm = mag2db(err_seg/data_len);
    
    noise_dlcIndex = err_dlcnorm > noise_thr;
    noise_segIndex = err_segnorm > noise_thr;
    
    
    figure;
    set(gcf, 'Position', [100, 200, 800, 400])
    subplot(411)
    plot(time, err_dlcnorm, '.b')
    hold on
    plot(time, err_segnorm, '.r')
    xlim([time(1), time(end)])
    ylabel('noise estimate')
    
    subplot(412)
    hold on
    plot(time, pupil_dlc, 'b')
    plot(time, pupil_dlc_hat, 'g')
    plot(time, 1*noise_dlcIndex-1, 'Color', 'k', 'LineWidth', 2)
    xlim([time(1), time(end)])
    ylabel('dlc-predict')
    
    subplot(413)
    hold on
    plot(time, pupil_seg, 'r')
    plot(time, pupil_seg_hat, 'g')
    plot(time, noise_segIndex-1, 'Color', 'k', 'LineWidth', 2)
    xlim([time(1), time(end)])
    ylabel('seg-predict')
    
    subplot(414)
    plot(time, pupil_dlc, 'b')
    hold on
    plot(time, pupil_seg, 'r')
    plot(time, pupil_fuse, 'Color', 'g', 'LineWidth', 2)
    xlim([time(1), time(end)])
    
    set(gca, 'Color', [0.9 0.9 0.9], ...
        'FontSize', 8)
    box off
    ylabel('Pupil-Fusion')
    
    legend({'DLC', 'ImageSeg', 'KF-Fusion'})
    
end

pupil.seg = pupil_seg;
% pupil.seg = pupil_seg_hat;
pupil.dlc = pupil_dlc;
% pupil.dlc = pupil_dlc_hat;
pupil.time = time;
pupil.fuse = pupil_fuse;
pupil.err_dlc = err_dlc;
pupil.err_seg = err_seg;
pupil.G_fuse = G_fuse;

pupil.p2mmRatio = pixel2mm_ratio;

warning('on')


