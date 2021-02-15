function [file1_New,file2_New] = op_samecell(file1,file2,same_cell)

chan_cell1 = child_cellchan(file1);
chan_cell2 = child_cellchan(file2);

file1_New = [];
file2_New = [];

for i_cell = 1:size(same_cell,1)
    cellindex = same_cell(i_cell,:);
    if sum(ismember(chan_cell1,cellindex,'rows')) == 1 && sum(ismember(chan_cell2,cellindex,'rows')) == 1
        file1_cell = file1{ismember(chan_cell1,cellindex,'rows')};
        file2_cell = file2{ismember(chan_cell2,cellindex,'rows')};
        
        waveform_file1_a = file1_cell.waveformT;
        elecnumber_file1 = file1_cell.Trodalness;
        waveform_file1_a = (waveform_file1_a - min(waveform_file1_a))/(max(waveform_file1_a) - min(waveform_file1_a));  % 对波形进行归一化
        waveform_file1_b = child_waveform1(waveform_file1_a,elecnumber_file1);
        
        waveform_file2_a = file2_cell.waveformT;
        elecnumber_file2 = file2_cell.Trodalness;
        waveform_file2_a = (waveform_file2_a - min(waveform_file2_a))/(max(waveform_file2_a) - min(waveform_file2_a));    % 对波形进行归一化
        waveform_file2_b = child_waveform1(waveform_file2_a,elecnumber_file1);
        
        [~, waveform_file2_c] = alignwaveforms(waveform_file1_a,waveform_file2_a,3);
        [~, waveform_file1_c] = alignwaveforms(waveform_file1_a,waveform_file1_a,3);
        
        [waveform1_corr,wavefomr2_corr ,C_1ms]= child_corr(waveform_file1_a,waveform_file2_a,elecnumber_file2);
        
        C_a = corrcoef(waveform_file1_a,waveform_file2_a);
        C_b = corrcoef(waveform_file1_b,waveform_file2_b);
        C_c = corrcoef(waveform_file1_c,waveform_file2_c);
        C_a = C_a(1,2);C_b = C_b(1,2);C_c = C_c(1,2);
        C = max([C_a,C_b,C_c]);
        
%         plot(waveform_file1_a);hold on
%         plot(waveform_file2_a,'r');title([num2str(C > .9),' ',num2str(C_1ms)])
%         pause
        
        if C >= 0.9
            cell1 = file1{ismember(chan_cell1,cellindex,'rows')} ; cell1.corr = C_1ms;
            cell2 = file2{ismember(chan_cell2,cellindex,'rows')} ; cell2.corr = C_1ms;
            file1_New{i_cell} = cell1;
            file2_New{i_cell}  = cell2;
        end
        
        close gcf
        
    end
end

if ~isempty(file1_New)
    
    if ~isequal(find(cellfun('isempty', file1_New)) ,find(cellfun('isempty', file2_New)))
        errror('last step error')
    end
    
    file1_New(cellfun('isempty',file1_New)) = [];
    file2_New(cellfun('isempty',file2_New)) = [];
end

end

function spikenew = child_waveform1(waveform,elecnumber)
OneEleclong = numel(waveform)/elecnumber;
spikenew = [];

for i = 1:elecnumber
    waveform1 = waveform((i-1)*OneEleclong+1:i*OneEleclong);
    
    waveform1  = (waveform1 - min(waveform1))/(max(waveform1) - min(waveform1));
    
    pre = 10; % 最小值前有12个点
    post = 36; % 最小值后有44个点
    ls = pre + post;
    
    int_factor = 2;
    s = 1:size(waveform1,2);
    ints = 1/int_factor:1/int_factor:size(waveform1,2);
    intspike = spline(s,waveform1,ints);
    
    [~,iaux] = min(intspike(pre*int_factor:pre*int_factor+16));
    iaux = iaux + pre*int_factor - 1;
    spike(pre:-1:1) = intspike(iaux:-int_factor:iaux-pre*int_factor+int_factor);
    spike(pre+1:ls) = intspike(iaux+int_factor:int_factor:iaux+post*int_factor);
    spikenew = [spikenew,spike];
    
end

end

function  cellchan = child_cellchan(file)
cellchan = zeros(numel(file),2);
for i_cell = 1:numel(file)
    cellchan(i_cell,:) = file{i_cell}.chancell;
end
end


function [waveform1_new,waveform2_new,C_value] = child_corr(waveform1,waveform2,elecnumber)

OneEleclong = numel(waveform1)/elecnumber;
cc = zeros(1,elecnumber);
waveform1_new  = [];
waveform2_new = [];
aaC = 0;
for i = 1:elecnumber
    waveform1_a = waveform1((i-1)*OneEleclong+1:i*OneEleclong);
    waveform2_a = waveform2((i-1)*OneEleclong+1:i*OneEleclong);
    [~, posi1] = min(waveform1_a);
    [~,posi2] = min(waveform2_a);
    try
        waveform1ms1 = waveform1_a(posi1 - 8 : posi1+32 - 1);
        waveform1ms2= waveform2_a(posi2 - 8 : posi2+32 - 1);
        aa = corrcoef(waveform1ms1,waveform1ms2);
    catch
        aa = [0, 0];
    end
    cc(i) = aa(1,2);
    if aa(1,2)  > aaC
        aaC = aa;
        waveform1_new = waveform1ms1;
        waveform2_new =  waveform1ms2;
    end
end
C_value = max(cc);

end
