function cut(datafile,prefix,variables,time)
str = strcat('../',datafile,'/',prefix,'00',num2str(time),'.sdf');
[b,h] = lv(str);
data=gd(b,h,variables);
grid=gd(b,h,'grid');
x=grid.x; y=grid.y;
x1=x(1:length(grid.x)-1);
y1=y(1:length(grid.y)-1);

n=floor(0.5*length(y1));
data_cut=data(1:length(x1),n);

plot(x1*1e6,data_cut,'r','LineWidth',2.5);
xlabel('x (\mum)'); ylabel(variables,'Interpreter','none');
%set(gcf,'position',[50,50,600,400]);
set(gca,'xlim',[40,140]);
set(gca, 'fontsize',15);
set(gca, 'linewidth',2);
hold on;
%axis square
%axis equal tight;
%axis equal
end