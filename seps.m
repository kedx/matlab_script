function seps(filename)
addpath('export_fig-master')
fn=['../pic/',filename,'.eps'];
set(gcf,'Color','white');
export_fig(fn,'-p14')
end