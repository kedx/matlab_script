function x_px(datafile,prefix,variables,time,minvalue,maxvalue)
% Get the data
str = strcat('../',datafile,'/',prefix,'00',num2str(time),'.sdf');
[b,h] = lv(str);
data1=gd(b,h,strcat('x_px/',variables));
grid=gd(b,h,strcat('grid/x_px/',variables));
x=grid.x; y=grid.y;
x1=x(1:length(grid.x)-1);
y1=y(1:length(grid.y)-1);
data=log10(data1+1);

% Plot range (colorbar) setting
if maxvalue==-1                      % Default setting
    maxvalue=max(max(data));
end
if minvalue==-1
    minvalue=min(min(data));
end

% Contour plot
%colormap(redblue);
colormap(jet);
set(gcf,'position',[50,50,600,400]);
set(gca, 'fontsize',11,'FontName','Helvetica');
%set(gca,'XLim', [-12.8 12.8],'YLim',[-6.4,6.4])
imagesc(x1*1e6,y1,data',[minvalue,maxvalue]);
axis xy;
colorbar;
xlabel('x (\mum)'); ylabel('px (\mum)');
hold on;
%axis square
%axis equal tight;
%axis equal
end