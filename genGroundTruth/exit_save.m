function exit_save

global result
[file, path] = uiputfile('*.mat');

if path == 0
    answer = questdlg('Do you really want close?', ...
        'Close confirm', ...
        'Yes', 'No', 'No thank you');
    
    % Handle response
    switch answer
        case 'Yes'
            delete(gcf)
            return
        case 'No'
            return
    end
    
else
    label_results = result.label_results;
    save([path, file], 'label_results');
    disp('The labeled result has been saved!')
    delete(gcf)
end
end