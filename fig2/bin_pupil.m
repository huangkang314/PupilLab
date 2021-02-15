function bined_pupil = bin_pupil(pupil, bins, time)

n_bins = length(bins);

bined_pupil = zeros(n_bins-1, 1);

for i=1:n_bins-1
    tem_idx = time>=bins(i) & time<bins(i+1);
    
    bined_pupil(i) = mean(pupil(tem_idx));
    
end


