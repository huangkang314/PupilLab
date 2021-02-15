function sP_bin = bin_eeg(sP, bins, time)

n_bins = length(bins);

sP_bin.alpha = zeros(n_bins-1, 1);
sP_bin.beta = zeros(n_bins-1, 1);
sP_bin.detla = zeros(n_bins-1, 1);
sP_bin.gamma = zeros(n_bins-1, 1);
sP_bin.theta = zeros(n_bins-1, 1);

for i=1:n_bins-1
    tem_idx = time>=bins(i) & time<bins(i+1);
    sP_bin.alpha(i) = mean(sP.alpha(tem_idx));
    sP_bin.beta(i) = mean(sP.beta(tem_idx));
    sP_bin.detla(i) = mean(sP.detla(tem_idx));
    sP_bin.gamma(i) = mean(sP.gamma(tem_idx));
    sP_bin.theta(i) = mean(sP.theta(tem_idx));
    
end


