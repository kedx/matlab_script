function s(filename)
fn=['../pic',filename,'.eps'];
set(gcf,'Color','white');
export_fig(fn,'-p14')
end