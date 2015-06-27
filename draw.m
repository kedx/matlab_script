function draw(datafile,variables,time,minvalue,maxvalue)
%=======================================================
% Plot range controled by minvalue and maxvalue.
% If don't need change, set as -1 to use default value.
%=======================================================

% Get the data
str = strcat('../',datafile,'/00',num2str(time),'.sdf');
[b,h] = lv(str);
data=gd(b,h,variables);
grid=gd(b,h,'grid');
x=grid.x; y=grid.y;
x1=x(1:length(grid.x)-1);
y1=y(1:length(grid.y)-1);

% Plot range (colorbar) setting
flag=0;
if maxvalue==-1                 % Default setting
    maxvalue=max(max(data));
end
if minvalue==-1
    minvalue=min(min(data));
    flag=1;
end
if minvalue<0 && flag==1                % Test if the plot is all above 0
    if maxvalue<abs(minvalue)
        maxvalue=abs(minvalue);      % Make colorbar symmetric
    end
    minvalue=-1*maxvalue;
end

% Contour plot
colormap(jet);
set(gcf,'position',[50,50,600,400]);
set(gca, 'fontsize',11,'FontName','Helvetica');
%set(gca,'XLim', [-12.8 12.8],'YLim',[-6.4,6.4])
imagesc(x1*1e6,y1*1e6,data',[minvalue,maxvalue]);
axis xy; axis equal tight;
colorbar;
xlabel('x (\mum)'); ylabel('y (\mum)');
hold on;
%axis square
%axis equal tight;
%axis equal
end