function den_log(datafile,prefix,variables,time,minvalue,maxvalue)
% Get the data
str = strcat('../',datafile,'/',prefix,'00',num2str(time),'.sdf');
[b,h] = lv(str);
data1=gd(b,h,variables);
grid=gd(b,h,'grid');
x=grid.x; y=grid.y;
x1=x(1:length(grid.x)-1);
y1=y(1:length(grid.y)-1);
data=log10(data1);
% Plot range (colorbar) setting
flag=0;
if maxvalue==-1                      % Default setting
    maxvalue=max(max(data));
end
if minvalue==-1
    minvalue=20;
    flag=1;
end
if minvalue<0 && flag==1             % Test if the plot is all above 0
    if maxvalue<abs(minvalue)
        maxvalue=abs(minvalue);      % Make colorbar symmetric
    end
    minvalue=-1*maxvalue;
end

% Contour plot
%colormap(redblue);
colormap(jet);
set(gcf,'position',[50,50,600,400]);
imagesc(x1*1e6,y1*1e6,data',[minvalue,maxvalue]);
%set(gca,'XLim', [-12.8 12.8],'YLim',[-6.4,6.4])
set(gca, 'fontsize',15,'FontName','Helvetica');
axis xy; axis equal tight;
colorbar;
xlabel('x (\mum)'); ylabel('y (\mum)');
hold on;
%axis square
%axis equal tight;
%axis equal
end