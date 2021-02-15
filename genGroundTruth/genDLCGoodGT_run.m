
work_path = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\yulinDataShort\';
data_path = dir([work_path, 'e*']);
n_data = length(data_path);


%get total bad frames
    
    noise_thr = -5;
    good_thr = -30;
    nPick_each = 20;
    nPick_total = n_data*nPick_each;
    pick_indexs = struct();
    for i = 1:n_data
        data_main = data_path(i).name(2:end);
        tem_prepro = load([work_path, data_main, '_preprocessed.mat']);
        pupil= tem_prepro.pupil;
        err_dlc = pupil.err_dlc;
        err_seg = pupil.err_seg;
        data_len = length(err_dlc);
        
        err_dlcnorm =mag2db(err_dlc/data_len);
        err_segnorm = mag2db(err_seg/data_len);

        pick_index = find(err_dlcnorm < good_thr & err_segnorm >  noise_thr);
        
        n_pick = length(pick_index);
        if n_pick < nPick_each
            pick_select = sort(randperm(n_pick, n_pick));
        else
            pick_select = sort(randperm(n_pick, nPick_each));
        end
        pick_indexs(i).videoPath = [work_path, data_main, '.avi'];
        pick_indexs(i).index = pick_index(pick_select);

        save('../genGroundTruth/pick_indexs_dlcGood_1025.mat', 'pick_indexs')
    end


