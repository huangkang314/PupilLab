function op_plottrace1by1(data)
% data中的每一行为一次数据，一行一行画
for i = 1: size(data,1)
    plot(data(i,:))
    pause
    close gcf
end

end