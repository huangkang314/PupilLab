function op_plottrace1by1(data)
% data�е�ÿһ��Ϊһ�����ݣ�һ��һ�л�
for i = 1: size(data,1)
    plot(data(i,:))
    pause
    close gcf
end

end