close all
% clear all

%%
data_path = '.\data\yulinDataShort\';
data_name = '#A4-1';

data = load([data_path, data_name, '_preprocessed.mat']);
vid_obj = VideoReader([data_path, data_name, '.avi']);

fsB = vid_obj.FrameRate;
startframe = round(0.17*fsB); endframe = 30*fsB;
downsamp = 1; 
showRange = [-10, 10];

seg = data.pupil.seg;
dlc = data.pupil.dlc;
fuse = data.pupil.fuse;
time = data.pupil.time;
max_seg = max(seg);
max_dlc = max(dlc);
max_fuse = max(fuse);
max_disp = 2;%max([max_seg, max_dlc, max_fuse]);
colors = [ [180, 64, 49]/255;  [80, 160, 66]/255; [62, 82, 190]/255];

writerObj = VideoWriter('video1.mp4', 'MPEG-4');
writerObj.FrameRate = 30;
writerObj.Quality = 100;
open(writerObj);

h1 = figure(1);
set(h1, 'Position', [600, 400, 1000, 250], 'Color', 'k')

pos = {[0.01 0.20 0.30 0.60], [0.34 0.20 0.65 0.60]};
%%

subplot('Position', pos{2});
p1 = plot(time, seg, 'Color', colors(1, :), 'LineWidth', 1);
hold on

p2 = plot(time, dlc, 'Color', colors(3, :), 'LineWidth', 1);
ylabel('Time (s)'); ylabel('Pupil')
hold on


p3 = plot(time, fuse, 'Color', colors(2, :), 'LineWidth', 1);
grid on
set(gca, 'Color', 'none', 'FontSize', 10, 'TickDir', 'out', 'TickLength',[0.002, 0.002], ...
    'Box', 'off', 'LineWidth', 0.5, 'XColor', 'w', 'YColor', 'w')
ylabel('Pupil rad./mm'); xlabel('Time (s)')
hold on
plt = plot([0/fsB 0/fsB], [0, max_disp], '--w');
ylim([0, max_disp+1])
hold off
legend([p1, p2, p3],  '\color{white} Seg', '\color{white} DLC', '\color{white} Fused', ...
    'Location',  'north', 'Orientation', 'horizontal', 'Box',  'off')

frame = read(vid_obj, 1);


tic
h1 = figure(1);

for fi = startframe:downsamp:endframe
    
    subplot('Position', pos{1});
    
    frame = read(vid_obj, fi);
    imshow(frame)
    axis equal
    
    title(['Time Lapse: ', num2str(round(round(1000*(fi-1)/fsB, 2)/1000, 0)), 's'], 'FontSize', 10, 'Color', 'w')
    
    subplot('Position', pos{2});
    xlim([(fi-1)/fsB+showRange(1), (fi-1)/fsB+showRange(2)])
    ylim([0, max_disp+0.5])
    
    set(plt, 'XData', [fi/fsB, fi/fsB])
    f = getframe(h1);
    writeVideo(writerObj, f.cdata);

    drawnow
    toc
end
close(writerObj);
