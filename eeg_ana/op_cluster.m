function [IDX,ran] = op_cluster(fea,index,colorspec,angle3D,type,path,method,distance,data)
% Z = linkage(fea,'average','Euclidean');  %'Euclidean'
Z = linkage(fea,method,distance);  

C = cluster(Z,'maxclust',3);
IDX = C;

H = dendrogram(Z,0,'colorthreshold','default','orientation','right');  
Z0 = int16(Z);
set(H,'color',[0 0 0])
outID = child_link(colorspec.increase,IDX,Z0);
outID(ismember(outID, [numel(index) - 1,numel(index) - 2])) = [];
set(H(outID),'color','r')

outID = child_link(colorspec.decrease,IDX,Z0);
outID(ismember(outID, [numel(index) - 1,numel(index) - 2])) = [];
set(H(outID),'color','b')

outID = child_link(colorspec.non,IDX,Z0);
outID(ismember(outID, [numel(index) - 1,numel(index) - 2])) = [];
set(H(outID),'color',[.6 .6 .6])

set(H,'linewidth',1.5)
set(gcf,'color',[1 1 1])
axis off
print(gcf,'-dpng','-r300',[path,'\epm tran\linkage',type,'.png']);
close gcf

data1 = mean(mean(data(IDX == 1,:)));
data2 = mean(mean(data(IDX == 2,:)));
data3 = mean(mean(data(IDX == 3,:)));
[~,ran] = sort([data1,data2,data3]);
markall = {'o','s','^'};

figure;hold on
for i = 1 : numel(IDX)
    % 三种形状
    if IDX(i) == 1
        mark = markall{ran(1)};
    elseif IDX(i)  == 2;
        mark = markall{ran(2)};
    elseif IDX(i) == 3;
        mark = markall{ran(3)};
    end
    % 四类神经元
    if index(i) == 1
        color =  [0 .5 .5];
    elseif index(i) == 2
        color = [.75 .75 0];
    elseif index(i) == 3
        color = 'b';
    elseif index(i) == 4
        color = [.8 .8 .8];
    end
    
    plot3(fea(i,1),fea(i,2),fea(i,3),'color',color,'Marker',mark,'MarkerSize',20,'MarkerFacecolor',color,....
        'markeredgecolor','k','linewidth',1.5)%
end
view(angle3D)
set(gcf,'color',[1 1 1]);set(gca,'Fontsize',20,'linewidth',1.5,'tickdir','out','xgrid','on','ygrid','on','zgrid','on','box','on')

% for i = 1:size(fea,1)
%     text(fea(i,2),fea(i,1),num2str(i),'Fontsize',13)
%     hold on
% end

end

function outID = child_link(colorspec,IDX,Z0)
ii = find(IDX == colorspec);
outID = -1;
while max(outID) < size(Z0,1)
    outID(outID == -1) = [];
    I = ismember(Z0(:,1:2),ii);
    I = logical(sum(I,2));
    I = find(I == 1);
    outID = [outID;I];
    ii = I+ numel(IDX);
end
outID = unique(outID);
end


