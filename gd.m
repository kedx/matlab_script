function re = gd(blocklist,h,vv);

n=h.nblocks;
for i=1:n
block=blocklist(i);
if strcmp(vv,block.id)
%fprintf('Get the Data: %s, and the blocktype: %i\n',vv,block.blocktype);
 h.fid = fopen(h.filename);
 fseek(h.fid, block.block_start + h.block_header_length, 'bof');
switch block.blocktype
 case h.BLOCKTYPE.PLAIN_VARIABLE

	mult = fread(h.fid, 1, 'float64');
	units = deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))'));
	block.mesh_id = deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))'));
	npts = fread(h.fid, block.ndims, 'int32');
	stagger = fread(h.fid, 1, 'int32');

	if block.datatype == h.DATATYPE.REAL4
    	typestring = 'single';
	elseif block.datatype == h.DATATYPE.REAL8
    	typestring = 'double';
	end

	offset = block.data_location;

	tagname = 'data';
	block.map = memmapfile(h.filename, 'Format', ...
        {typestring npts' tagname}, 'Offset', offset, ...
        'Repeat', 1, 'Writable', false);
	%q.(tagname) = block.map.data.(tagname);
	re = block.map.data.(tagname);
	%set(gca,'ydir','normal')
	fclose(h.fid);


 case h.BLOCKTYPE.POINT_VARIABLE

	mult = fread(h.fid, 1, 'float64');
	units = deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))'));
	block.mesh_id = deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))'));
	npart = fread(h.fid, 1, 'int64');

	if block.datatype == h.DATATYPE.REAL4
    	typestring = 'single';
	elseif block.datatype == h.DATATYPE.REAL8
        typestring = 'double';
	end

	offset = block.data_location;

	tagname = 'data';
	block.map = memmapfile(h.filename, 'Format', ...
        	{typestring npart tagname}, 'Offset', offset, ...
        	'Repeat', 1, 'Writable', false);
	%q.(tagname) = block.map.data.(tagname);
	re = block.map.data.(tagname);
	 
 case h.BLOCKTYPE.CONSTANT
	fprint('sdf');
	typestring = 'float64';
	if block.datatype == h.DATATYPE.REAL4
    	typestring = 'float32';
	elseif block.datatype == h.DATATYPE.REAL8
    	typestring = 'float64';
	elseif block.datatype == h.DATATYPE.INTEGER4
    	typestring = 'int32';
	elseif block.datatype == h.DATATYPE.INTEGER8
    	typestring = 'int64';
	end

	re = fread(h.fid, 1, typestring);


 case h.BLOCKTYPE.POINT_MESH
	mults = fread(h.fid, block.ndims, 'float64');
	for n=1:block.ndims
	  labels{n} = { deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))')) };
	end
	for n=1:block.ndims
	  units{n} = { deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))')) };
	end
	geometry = fread(h.fid, 1, 'int32');
	extents = fread(h.fid, 2*block.ndims, 'float64');
	npart = fread(h.fid, 1, 'int64');
	re.labels = labels;
	re.units = units;
	
	if block.datatype == h.DATATYPE.REAL4
	    typestring = 'single';
	elseif block.datatype == h.DATATYPE.REAL8
	    typestring = 'double';
	end
	
	nelements = 0;
	for n=1:block.ndims
	    nelements = nelements + npart;
	end
	typesize = block.data_length / nelements;
	
	offset = block.data_location;
	
	tags = ['x' 'y' 'z' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n'];
	for n=1:block.ndims
	    tagname = tags(n);
	    block.map = memmapfile(h.filename, 'Format', ...
	            {typestring [npart] tagname}, 'Offset', offset, ...
	            'Repeat', 1, 'Writable', false);
	    re.(tagname) = block.map.data.(tagname);
	    offset = offset + typesize * npart;
	end
	
  case h.BLOCKTYPE.PLAIN_MESH
	mults = fread(h.fid, block.ndims, 'float64');
	for n=1:block.ndims
	  labels{n} = { deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))')) };
	end
	for n=1:block.ndims
	  units{n} = { deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))')) };
	end
	geometry = fread(h.fid, 1, 'int32');
	extents = fread(h.fid, 2*block.ndims, 'float64');
	npts = fread(h.fid, block.ndims, 'int32');
	re.labels = labels;
	re.units = units;
	
	if block.datatype == h.DATATYPE.REAL4
	    typestring = 'single';
	elseif block.datatype == h.DATATYPE.REAL8
	    typestring = 'double';
	end
	
	nelements = 0;
	for n=1:block.ndims
	    nelements = nelements + npts(n);
	end
	typesize = block.data_length / nelements;
	
	%fseek(h.fid, block.data_location, 'bof');
	offset = block.data_location;
	
	tags = ['x' 'y' 'z' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n'];
	for n=1:block.ndims
	    tagname = tags(n);
	    block.map = memmapfile(h.filename, 'Format', ...
	            {typestring [npts(n)] tagname}, 'Offset', offset, ...
	            'Repeat', 1, 'Writable', false);
	    re.(tagname) = block.map.data.(tagname);
	    offset = offset + typesize * npts(n);
	end



end
return

%else
%re = 0;
end %if

end %for
fprintf('Wrong Variable\n');


