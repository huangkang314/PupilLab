function op_P_value_on2Dplot(xx,yy,Pvalue,thr)
% 这个函数是在时频图的基础上标注出Pvalue 小于thr的范围
%%
longthr = 5;
hold on;
PvalueR = Pvalue < thr;
rows = size(Pvalue,1);
cols = size(Pvalue,2);

for i_rows = 2 : rows-1
    findvalue = 1;
    [pos,long] = op_findsamevalueInterval2(PvalueR(i_rows,:), findvalue);
    if ~isempty(pos)
        pos(:,1) = pos;pos(:,2) = pos(:,1)+long - 1;
        for j = 1 : size(pos,1)
            pos1 = pos(j,:);
            long1 = long(j);
            if long1 < longthr
                PvalueR(i_rows,pos1(1):pos1(2)) = 0;
            end
        end
    end
end

for i_cols = 1 : cols
    col1 = PvalueR(:,i_cols);
    findvalue = 1;
    [pos,long] = op_findsamevalueInterval2(col1, findvalue);
    if ~isempty(pos)
        pos(:,1) = pos;pos(:,2) = pos(:,1)+long - 1;
        for j = 1 : size(pos,1)
            pos1 = pos(j,:);
            long1 = long(j);
            if long1 < 2
                PvalueR(pos1(1):pos1(2),i_cols) = 0;
            end
        end
    end
    
end

for i_rows = 2 : rows-1
    findvalue = 1;
    [pos,long] = op_findsamevalueInterval2(PvalueR(i_rows,:), findvalue);
    if ~isempty(pos)
        pos(:,1) = pos;pos(:,2) = pos(:,1)+long - 1;
        for j = 1 : size(pos,1)
            pos1 = pos(j,:);
            plot(xx(pos1(1)),yy(i_rows),'o','color',[0 0 0],'markersize',3,'markerfacecolor',[0 0 0])
            plot(xx(pos1(2)),yy(i_rows),'o','color',[0 0 0],'markersize',3,'markerfacecolor',[0 0 0])
                
%                 pointX = [xx(pos1(1)),xx(pos1(2))];
%                 pointY = [yy(i_rows),yy(i_rows)];
%                 plot(pointX,pointY,'color',[0 0 0],'linewidth',1)

        end
    end
end

for i_cols = 1 : cols
    col1 = PvalueR(:,i_cols);
    findvalue = 1;
    [pos,long] = op_findsamevalueInterval2(col1, findvalue);
    if ~isempty(pos)
        pos(:,1) = pos;pos(:,2) = pos(:,1)+long - 1;
        for j = 1 : size(pos,1)
                
                pos1 = pos(j,:);
                plot(xx(i_cols),yy(pos1(1)),'o','color',[0 0 0],'markersize',3,'markerfacecolor',[0 0 0])
                plot(xx(i_cols),yy(pos1(2)),'o','color',[0 0 0],'markersize',3,'markerfacecolor',[0 0 0])
                
%                 pointX = [xx( i_cols),xx( i_cols)];
%                 pointY = [yy(pos1(1)),yy(pos1(2))];
%                 plot(pointX,pointY,'color',[0 0 0],'linewidth',1)

        end
      
    end
    
end





%%
end