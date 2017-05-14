function xpx_hist(datafile,variables,time,res)
str = strcat('../',datafile,'/part_info00',num2str(time),'.sdf');
[b,h] = lv(str);
part_grid=gd(b,h,strcat('grid/subset_background/',variables));
px=gd(b,h,strcat('px/subset_background/',variables));
weight=gd(b,h,strcat('weight/subset_background/',variables));
part_x=part_grid.x; 

% part_y=part_grid.y;
% num=find(part_y>-5e-6 & part_y<5e-6);
% px=px(num);
% weight=weight(num);
% part_x=part_x(num);

% Do statistics
xrange=linspace(min(part_x),max(part_x),res);
yrange=linspace(min(px),max(px),res);
data=[part_x px weight];
for i=1:length(xrange)-1
    data((data(:,1)>xrange(i))&(data(:,1)<=xrange(i+1)),4)=i;
end
for i=1:length(yrange)-1  
    data((data(:,2)>yrange(i))&(data(:,2)<=yrange(i+1)),5)=i; 
end
count=zeros(length(xrange)-1,length(yrange)-1);
data=data(data(:,4)>0,:);% if a data point is out of range, throw it away
data=data(data(:,5)>0,:);
for i=1:size(data,1)
    count(data(i,4),data(i,5))=count(data(i,4),data(i,5))+data(i,3)*100;
end

% Generate figure
colormap(jet)
imagesc(xrange*1e6,yrange,log10(count)')
axis xy; colorbar; caxis([0,log10(max(max(count)))]);
set(gca,'fontsize',15)
end