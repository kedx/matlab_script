function seps
[filename,pathname]=uiputfile({'*.eps';'*.png'},'Save as');
addpath('altmany-export_fig-97e0640')
fn=[pathname,filename];
%set(figure(1),'position',[50,50,350,300]);
set(figure(1),'Color','white');
export_fig(fn,'-p0')
end
% By the way, if you are bothered by a white line
% accross your figure when exporting 'eps' file
% please open this file with iDraw, select image and 'ungroup'
% that question can be solved.