function pupilRaw = extractPupil_dlc(dlcFileName, lhThr, method)
% lhThr - the threshold of the reliable tracked points (above this thrshold)
% pixel2mm_ratio = 1/55.35 -


track_data = importfile(dlcFileName, [4, Inf]);
pupil_data = table2array(track_data);

data_len = size(pupil_data, 1);

%% fit pupil DLC
pupilRaw = zeros(data_len, 1);
zb_arr = zeros(data_len, 2);
ab_arr = zeros(data_len, 1);
bb_arr = zeros(data_len, 1);
alphab_arr = zeros(data_len, 1);

avg_rad = 0;
ab = 0;

for i = 1:data_len
    tem_dataX = pupil_data(i, 2:3:end)'; % according to csv
    tem_dataY = pupil_data(i, 3:3:end)';
    tem_data = [tem_dataX, tem_dataY];
    center_data = tem_data(1, :);
    contour_data = tem_data(2:end, :);
    lh = pupil_data(i, 7:3:end);
    bad_col = find(lh < lhThr);
    contour_data(bad_col, :) = [];
    %     plot_dataX = tem_data(:, 1);
    %     plot_dataY = tem_data(:, 2);
    if strcmp(method, 'ellipsefit')
        try
            [zb, ab, bb, alphab] = fitellipse(contour_data, 'linear');
            zb_arr(i, :) = zb';
            ab_arr(i, :) = ab;
            bb_arr(i, :) = bb;
            alphab_arr(i, :) = alphab;
        catch
            zb_arr(i, :) = zb';
            ab_arr(i, :) = ab;
            bb_arr(i, :) = bb;
            alphab_arr(i, :) = alphab;
        end
        pupilRaw(i) = ab;
    elseif strcmp(method, 'average')
        if ~isempty(contour_data)
            radii = contour_data - center_data;
            rads = sqrt(radii(:, 1).^2 + radii(:, 2).^2);
            avg_rad = mean(rads);
            pupilRaw(i) = avg_rad;
        else
            pupilRaw(i) = avg_rad;
        end
    end
end
%%

