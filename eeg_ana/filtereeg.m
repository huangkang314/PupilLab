function filtered_data = filtereeg(fs, eeg)

% load filter
load('./eeg_ana/filter0.5-3Hz.mat');
Hd_total.detla = Hd;
load('./eeg_ana/filter3-8Hz.mat');
Hd_total.theta = Hd;
load('./eeg_ana/filter8-12Hz.mat'); % 5-9
Hd_total.alpha = Hd;
load('./eeg_ana/filter12-30Hz.mat'); % 9-13
Hd_total.beta = Hd;
load('./eeg_ana/filter30-80Hz.mat');
Hd_total.gamma = Hd;
load('./eeg_ana/filter50Hz.mat')
Hd_total.a50Hz = Hd;

filtered_data = filter_chl(eeg', Hd_total, fs);

end

%% funtion of filtering
function dataout = filter_chl(data, Hd, Fs)

disp('filtering 50 Hz ...')
data = filtfilt(Hd.a50Hz.sosMatrix,Hd.a50Hz.ScaleValues,data);
disp('filtering detla ...')
detla = filtfilt(Hd.detla.sosMatrix,Hd.detla.ScaleValues,data);     % detla
disp('filtering theta ...')
theta = filtfilt(Hd.theta.sosMatrix,Hd.theta.ScaleValues,data);     % theta
disp('filtering alpha ...')
alpha = filtfilt(Hd.alpha.sosMatrix,Hd.alpha.ScaleValues,data);     % alpha
disp('filtering beta ...')
beta = filtfilt(Hd.beta.sosMatrix,Hd.beta.ScaleValues,data);     % beta
disp('filtering gamma ...')
gamma = filtfilt(Hd.gamma.sosMatrix,Hd.gamma.ScaleValues,data);     % gamma

% dataout.detla = detla(3 * Fs + 1: end - 3 * Fs);
% dataout.theta = theta(3 * Fs + 1: end - 3 * Fs);
% dataout.alpha = alpha(3 * Fs + 1: end - 3 * Fs);
% dataout.beta = beta(3 * Fs + 1: end - 3 * Fs);
% dataout.gamma = gamma(3 * Fs + 1: end - 3 * Fs);

dataout.detla = detla;
dataout.theta = theta;
dataout.alpha = alpha;
dataout.beta = beta;
dataout.gamma = gamma;

end