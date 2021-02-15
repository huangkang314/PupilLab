function [index_interneruon IDX] = op_plot_wavefea4(fea,index,title_str,class1,class2,class3)
% 根据输入的特征，对神经元进行分类

Z = linkage(fea,'ward','Euclidean');  %'Euclidean'
% Z = linkage(fea,'complete','Euclidean');  
H = dendrogram(Z,'colorthreshold','default','orientation','left');  
set(H,'linewidth',2)
set(gcf,'color',[1 1 1])

C = cluster(Z,'maxclust',3);
IDX = C;

outlier_pv=(IDX==3)&(fea(:,1)<20|fea(:,2)<22|fea(:,3)>0.25);
outlier_msn=(IDX==1)&(fea(:,1)>15|fea(:,2)>=22|fea(:,3)<=0.25);

IDX([outlier_msn])=4;
IDX([outlier_pv])=4;
% for i=1:size(fea,1)
%     if fea(i,1)>20&&fea(i,2)>=22&&fea(i,3)<=0.25
%         IDX(i)=1;
%     elseif fea(i,1)<20&&fea(i,2)<22&&fea(i,3)>0.25
%         IDX(i)=3;
%     end
% end

% if mean(fea(IDX == 1,1)) < mean(fea(IDX == 2,1))
%    IDX1(IDX == 1) = 2;
%    IDX1(IDX == 2) = 1;
%    IDX = IDX1'; 
% end

plot3(fea(IDX == 3,3),fea(IDX == 3,2),fea(IDX == 3,1),'ko','MarkerSize',15,'linewidth',2);%,'MarkerFacecolor','r')
index1 = find(IDX == 1);countinred = ismember(index,index1);ratioinred = sum(countinred)/numel(index);

hold on
plot3(fea(IDX == 2,3),fea(IDX == 2,2),fea(IDX == 2,1),'k^','MarkerSize',15,'linewidth',2);%,'MarkerFacecolor','b')
index2 = find(IDX == 2);countingreen = ismember(index,index2);ratioingreen = sum(countingreen)/numel(index);

hold on
plot3(fea(IDX == 1,3),fea(IDX == 1,2),fea(IDX == 1,1),'ks','MarkerSize',15,'linewidth',2);%,'MarkerFacecolor','g')
index3 = find(IDX == 3);countinblue = ismember(index,index3);ratioinblue = sum(countinblue)/numel(index);

hold on
plot3(fea(IDX == 4,3),fea(IDX == 4,2),fea(IDX == 4,1),'kx','MarkerSize',15,'linewidth',2,'MarkerEdgecolor',[0.5 0.5 0.5])
index3 = find(IDX == 4);countinblue = ismember(index,index3);ratioinblue = sum(countinblue)/numel(index);


index = find(class1 == 1);
if ~isempty(index)
    for i = 1:numel(index)
        index1 = index(i);
        if IDX(index1) == 3 
            plot3(fea(index1,3), fea(index1,2),fea(index1,1),'ko','Markersize',15,'MarkerFacecolor','yellow');
        elseif IDX(index1) == 2
            plot3(fea(index1,3), fea(index1,2),fea(index1,1),'k^','Markersize',15,'MarkerFacecolor',[1 1 1]);
         elseif IDX(index1) ==1
             plot3(fea(index1,3), fea(index1,2),fea(index1,1),'ks','Markersize',15,'MarkerFacecolor','yellow'); 
        end
    end
end

index = find(class2 == 1);
if ~isempty(index)
    for i = 1:numel(index)
        index1 = index(i);
       if IDX(index1) == 3 
            plot3(fea(index1,3), fea(index1,2),fea(index1,1),'ko','Markersize',15,'MarkerFacecolor','blue');
        elseif IDX(index1) == 2
            plot3(fea(index1,3), fea(index1,2),fea(index1,1),'k^','Markersize',15,'MarkerFacecolor',[1 1 1]);
         elseif IDX(index1) == 1
             plot3(fea(index1,3), fea(index1,2),fea(index1,1),'ks','Markersize',15,'MarkerFacecolor','blue'); 
        end
    end
end

index = find(class3 == 1);
if ~isempty(index)
    for i = 1:numel(index)
        index1 = index(i);
        if IDX(index1) == 3
            plot3(fea(index1,3), fea(index1,2),fea(index1,1),'ko','Markersize',15,'MarkerFacecolor',[1 1 1]);
        elseif IDX(index1) == 2
            plot3(fea(index1,3), fea(index1,2),fea(index1,1),'k^','Markersize',15,'MarkerFacecolor',[1 1 1]);
         elseif IDX(index1) == 1
             plot3(fea(index1,3), fea(index1,2),fea(index1,1),'ks','Markersize',15,'MarkerFacecolor',[1 1 1]); 
        end
    end
end

% for i = 1:size(fea,1)
%     text(fea(i,3), fea(i,2),fea(i,1),num2str(i),'Fontsize',13)
%     hold on
% end


% legend('putative fast spiking neurons','putative non-fast spiking neurons','location','NE')
% legend boxoff
% ylim([0 1.5])
set(gcf,'color',[1 1 1]);set(gca,'Fontsize',20,'linewidth',2,'tickdir','out')

zlabel('Firing rate [Hz]','Fontsize',20);zlim([0 60]);

set(gca,'XDir','reverse','YDir','reverse');
ylabel('ISVD','Fontsize',20);ylim([0 60]);
xlabel('HDT [ms]','Fontsize',20);xlim([0 0.4]);
% title(title_str,'Fontsize',15)

grid on
axis square

index_interneruon = IDX == 3;
box off
%title([{'Segregation of putative fast spiking neurons'}, {'and putative non-fast spiking neurons'}],'Fontsize',15)


% title([num2str(sum(countinred)),' ',num2str(roundn(ratioinred,-2)*100),'% Red ',num2str(sum(countinblue)),' ',...
%     num2str(roundn(ratioinblue,-2)*100),'% in Blue ','---Red ',num2str(sum(IDX == 1)),' Blue ',num2str(sum(IDX == 2))],'Fontsize',15)

end