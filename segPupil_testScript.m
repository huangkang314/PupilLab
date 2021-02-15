obj = VideoReader('D:\huangkang\Projects\pupilLab\code\PupilLab\data\rawData\26.avi');
NumberOfFrames = obj.NumberOfFrames;
show_process = false;
%
la_imagen=read(obj,10);
filas=size(la_imagen,1);
columnas=size(la_imagen,2);
% Center
centro_fila=round(filas/2);
centro_columna=round(columnas/2);

figure(1)
% draw mask
imshow(read(obj,1000));
% h = drawfreehand;
h  =drawcircle;
BW = createMask(h);
la_imagen=rgb2gray(la_imagen);
la_imagen(~BW) = [];
threshold = mean(la_imagen)/255;
close

pupil_seg = zeros(1, NumberOfFrames);
wbar = waitbar(0, 'Segmenting Pupil ...');
%%
if show_process
    figure(1)
end
for cnt = 1:NumberOfFrames
    la_imagen=read(obj,cnt);
    if size(la_imagen,3)==3
        la_imagen=rgb2gray(la_imagen);
    end
    
    piel=~im2bw(la_imagen, threshold);
    %     --
    piel=bwmorph(piel,'close');
    piel=bwmorph(piel,'open');
    piel=imfill(piel,'holes');
    
    if show_process
        subplot(212)
        imagesc(piel);
    end
    
    % Tagged objects in BW image
    L=bwlabel(piel);
    % Get areas and tracking rectangle
    out_a=regionprops(L);
    % Count the number of objects
    N=size(out_a,1);
    if N < 1 || isempty(out_a) % Returns if no object in the image
        solo_cara=[ ];
        continue
    end
    % ---
    % Select larger area
    areas=[out_a.Area];
    [area_max pam]=max(areas);
    
    if show_process
        subplot(211)
        imagesc(la_imagen);
        colormap gray
        hold on
        rectangle('Position',out_a(pam).BoundingBox,'EdgeColor',[1 0 0],...
            'Curvature', [1,1],'LineWidth',2)
        centro=round(out_a(pam).Centroid);
        X=centro(1);
        Y=centro(2);
        plot(X,Y,'g+')
        %
        text(X+10,Y,['(',num2str(X),',',num2str(Y),')'],'Color',[1 1 1])
        if X<centro_columna && Y<centro_fila
            title('Top left')
        elseif X>centro_columna && Y<centro_fila
            title('Top right')
        elseif X<centro_columna && Y>centro_fila
            title('Bottom left')
        else
            title('Bottom right')
        end
        hold off
    else
        
        
    end
    % --
    drawnow;

    pupil_seg(cnt) = max([out_a(pam).BoundingBox(3), out_a(pam).BoundingBox(4)]);
    waitbar(cnt/NumberOfFrames, wbar, sprintf(['Progress: ', num2str(cnt), '/', num2str(NumberOfFrames), ]))
end
close(wbar)

