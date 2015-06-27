function en(datafile,variables,time,color)
str = strcat('../',datafile,'/00',num2str(time),'.sdf');
[b,h] = lv(str);
en=gd(b,h,strcat('en/',variables));
num=gd(b,h,strcat('grid/en/',variables));
x=num.x;

set(gcf,'position',[50,50,600,400]);
set(gca, 'fontsize',11);
set(gca, 'linewidth',2);

semilogy(x/(1.602e-19*1e6),en,color,'LineWidth',2.5);
axis([0 70 1e8 1e16]);
xlabel('Energy (MeV)'); ylabel(strcat('number of ',variables,' (arb. units)'));
grid on;
hold on;
%axis square
%axis equal tight;
%axis equal
end