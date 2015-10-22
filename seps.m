function seps(filename)
addpath('export_fig')
fn=['../pic/',filename,'.eps'];
set(gcf,'Color','white');
export_fig(fn,'-p14')
end
% By the way, if you are bothered by a white line
% accross your figure when exporting 'eps' file
% please open this file with iDraw, select image and 'ungroup'
% that question can be solved.
