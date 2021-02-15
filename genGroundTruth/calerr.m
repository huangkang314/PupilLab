function [err_seg, err_dlc, err_fuse, noise_segnorm, noise_dlcnorm] = calerr(prepro_dataPath, label_resultFile)

data_path = dir([prepro_dataPath, 'e*']);
n_data = length(data_path);
load(label_resultFile);


% get the informatin of all videos

err_dlc = []; err_seg = []; err_fuse = []; noise_seg = []; noise_dlc = [];
for i = 1:n_data
    data_main = data_path(i).name(2:end);
    tem_prepro = load([prepro_dataPath, data_main, '_preprocessed.mat']);
    pupil_dlc = tem_prepro.pupil.dlc;
    pupil_seg = tem_prepro.pupil.seg;
    pupil_fuse = tem_prepro.pupil.fuse;
    pupil_label = label_results{1, i};
    
    data_len = length(pupil_seg);
    
    n_temGT = size(pupil_label, 2);
    pix2mm_ratio = tem_prepro.pupil.p2mmRatio;
    
    % calculate error for each picked frame
    for ip = 1:n_temGT
        index = pupil_label(ip).index;
        pupil_gt = max(pupil_label(ip).SemiAxes)*pix2mm_ratio;
        err_dlc = [err_dlc, pupil_dlc(index) - pupil_gt];
        err_seg = [err_seg, pupil_seg(index) - pupil_gt];
        err_fuse = [err_fuse, pupil_fuse(index) - pupil_gt];
        noise_seg = [noise_seg, tem_prepro.pupil.err_seg(index)];
        noise_dlc = [noise_dlc, tem_prepro.pupil.err_dlc(index)];
        
    end
    
    noise_segnorm = mag2db(noise_seg/data_len);
    noise_dlcnorm =mag2db(noise_dlc/data_len);
    
end


