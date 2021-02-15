function index_interneruon = op_plot_wavefea(fea,index,title_str,class1,class2,class3)
% 根据输入的特征，对神经元进行分类

Z = linkage(fea,'ward','Euclidean');  %'Euclidean'
% Z = linkage(fea,'complete','Euclidean');  
H = dendrogram(Z,'colorthreshold','default','orientation','left');  
set(H,'linewidth',2)
set(gcf,'color',[1 1 1])
axis off
C = cluster(Z,'maxclust',1);
IDX = C;

if mean(fea(IDX == 1,1)) < mean(fea(IDX == 2,1))
   IDX1(IDX == 1) = 2;
   IDX1(IDX == 2) = 1;
   IDX = IDX1'; 
end

plot(fea(IDX == 1,2),fea(IDX == 1,1),'ko','MarkerSize',15,'linewidth',2,'MarkerFacecolor','b')%(,'MarkerFacecolor','r')
index1 = find(IDX == 1);countinred = ismember(index,index1);ratioinred = sum(countinred)/numel(index);

hold on
plot(fea(IDX == 2,2),fea(IDX == 2,1),'ks','MarkerSize',15,'linewidth',2,'MarkerFacecolor','b')%(,'MarkerFacecolor','b')
index2 = find(IDX == 2);countinblue = ismember(index,index2);ratioinblue = sum(countinblue)/numel(index);

index = find(class1 == 1);
if ~isempty(index)
    for i = 1:numel(index)
        index1 = index(i);
        if IDX(index1) == 1 
            plot(fea(index1,2),fea(index1,1),'ko','Markersize',15,'MarkerFacecolor',[0 .5 .5]);
        elseif IDX(index1) == 2
            plot(fea(index1,2),fea(index1,1),'ks','Markersize',15,'MarkerFacecolor',[0 .5 .5]);
        end
    end
end

index = find(class2 == 1);
if ~isempty(index)
    for i = 1:numel(index)
        index1 = index(i);
        if IDX(index1) == 1 
            plot(fea(index1,2),fea(index1,1),'ko','Markersize',15,'MarkerFacecolor',[.75 .75 0]);
        elseif IDX(index1) == 2
            
            plot(fea(index1,2),fea(index1,1),'ks','Markersize',15,'MarkerFacecolor',[.75 .75 0]);
        end
    end
end

index = find(class3 == 1);
if ~isempty(index)
    for i = 1:numel(index)
        index1 = index(i);
        if IDX(index1) == 1 
            plot(fea(index1,2),fea(index1,1),'ko','Markersize',15,'MarkerFacecolor','b');
        elseif IDX(index1) == 2
            
            plot(fea(index1,2),fea(index1,1),'ks','Markersize',15,'MarkerFacecolor','b');
        end
    end
end

% for i = 1:size(fea,1)
%     text(fea(i,2),fea(i,1),num2str(i),'Fontsize',13)
%     hold on
% end


% legend('putative fast spiking neurons','putative non-fast spiking neurons','location','NE')
% legend boxoff
% ylim([0 1.5])
set(gcf,'color',[1 1 1]);set(gca,'Fontsize',20,'linewidth',2,'tickdir','out')
ylabel('Bursting rate','Fontsize',20)
xlabel('Firing rate','Fontsize',20)
% title(title_str,'Fontsize',15)

index_interneruon = IDX == 1;
box off
%title([{'Segregation of putative fast spiking neurons'}, {'and putative non-fast spiking neurons'}],'Fontsize',15)


% title([num2str(sum(countinred)),' ',num2str(roundn(ratioinred,-2)*100),'% Red ',num2str(sum(countinblue)),' ',...
%     num2str(roundn(ratioinblue,-2)*100),'% in Blue ','---Red ',num2str(sum(IDX == 1)),' Blue ',num2str(sum(IDX == 2))],'Fontsize',15)

end