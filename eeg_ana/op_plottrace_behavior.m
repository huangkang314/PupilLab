function op_plottrace_behavior(xls_path,posdiff,path)
data = xlsread(xls_path);
pos(:, 1) = data(:, 2);
pos(:, 2) = data(:, 3);
posdiff = logical(data(:, posdiff));

NumPos = size(pos,1);
figure;hold on
for i_pos = 2 : NumPos - 1
    posbef = pos(i_pos,:);
    posaft = pos(i_pos + 1,:);
    if (posdiff(i_pos + 1) || posdiff(i_pos)) == 1
        color = 'r';
    else 
        color = [.6 .6 .6];
    end
    line([posbef(1),posaft(1)],[posbef(2),posaft(2)],'marker','none','LineStyle','-','LineWidth',2,'Color',color)
end
set(gcf,'color',[1 1 1]);
axis off;
print(gcf,'-dtiff','-r600',[path,'.tiff']);
close gcf
end