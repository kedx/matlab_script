function en_hist(datafile,variables,time,res)
str = strcat('../',datafile,'/part_info00',num2str(time),'.sdf');
[b,h] = lv(str);
ek=gd(b,h,strcat('ek/subset_background/',variables));
weight=gd(b,h,strcat('weight/subset_background/',variables));

% Do statistics
xrange=linspace(0.0,max(ek),res);
data=[ek weight];
for i=1:length(xrange)-1
    data((data(:,1)>xrange(i))&(data(:,1)<=xrange(i+1)),3)=i;
end
count=zeros(length(xrange),1);
data=data(data(:,3)>0,:);% if a data point is out of range, throw it away
for i=1:size(data,1)
    count(data(i,3))=count(data(i,3))+data(i,2)*100;
end

% Generate figure
semilogy(xrange/(1e6*1.6e-19),count,'linewidth',1.5)
xlabel('energy (MeV)')
ylabel(strcat('number of',32,variables))
set(gca,'fontsize',15,'linewidth',1.5)
end