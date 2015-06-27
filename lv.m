function [blocklist,h] = lv(filename)
if nargin==0
filename='../cmr/0001.sdf'
end

global block;

%%%%%%%%%%%%%%%%%

h.ID_LENGTH = 32;
h.ENDIANNESS = 16911887;
h.VERSION = 1;
h.REVISION = 3;
h.MAGIC = 'SDF1';

h.BLOCKTYPE.SCRUBBED = -1;
h.BLOCKTYPE.NULL = 0;
h.BLOCKTYPE.PLAIN_MESH = 1;
h.BLOCKTYPE.POINT_MESH = 2;
h.BLOCKTYPE.PLAIN_VARIABLE = 3;
h.BLOCKTYPE.POINT_VARIABLE = 4;
h.BLOCKTYPE.CONSTANT = 5;
h.BLOCKTYPE.ARRAY = 6;
h.BLOCKTYPE.RUN_INFO = 7;
h.BLOCKTYPE.SOURCE = 8;
h.BLOCKTYPE.STITCHED_TENSOR = 9;
h.BLOCKTYPE.STITCHED_MATERIAL = 10;
h.BLOCKTYPE.STITCHED_MATVAR = 11;
h.BLOCKTYPE.STITCHED_SPECIES = 12;
h.BLOCKTYPE.FAMILY = 13;

h.BLOCKTYPE_NAME = { 'Invalid block'; 'Plain mesh'; 'Point mesh'; ...
    'Plain variable'; 'Point variable'; 'Constant'; 'Simple array'; ...
    'Run information'; 'Source code'; 'Stitched tensor'; ...
    'Stitched material'; 'Stitched material variable'; 'Stitched species'; ...
    'Particle family' };

h.DATATYPE.NULL = 0;
h.DATATYPE.INTEGER4 = 1;
h.DATATYPE.INTEGER8 = 2;
h.DATATYPE.REAL4 = 3;
h.DATATYPE.REAL8 = 4;
h.DATATYPE.REAL16 = 5;
h.DATATYPE.CHARACTER = 6;
h.DATATYPE.LOGICAL = 7;
h.DATATYPE.OTHER = 8;

%%%%%%%%%%%%%%%%

h.filename = filename;
h.fid = fopen(h.filename);

if h.fid == -1; disp('bad filename'); q = 'fail'; return; end

% File header
sdf_magic = char(fread(h.fid, 4, 'uchar'))';
endianness = fread(h.fid, 1, 'int32');
version = fread(h.fid, 1, 'int32');
revision = fread(h.fid, 1, 'int32');
code_name = deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))'));
first_block_location = fread(h.fid, 1, 'int64');
summary_location = fread(h.fid, 1, 'int64');
summary_size = fread(h.fid, 1, 'int32');
nblocks = fread(h.fid, 1, 'int32');

h.nblocks=nblocks; % output nblocks

h.block_header_length = fread(h.fid, 1, 'int32');
q.step = fread(h.fid, 1, 'int32');
q.time = fread(h.fid, 1, 'float64');
jobid1 = fread(h.fid, 1, 'int32');
jobid2 = fread(h.fid, 1, 'int32');
string_length = fread(h.fid, 1, 'int32');
code_io_version = fread(h.fid, 1, 'int32');

% Now seek to first block
b.block_start = first_block_location;

for n = 1:nblocks
    fseek(h.fid, b.block_start, 'bof');
    b.next_block_location = fread(h.fid, 1, 'uint64');
    b.data_location = fread(h.fid, 1, 'uint64');
    b.id = deblank(strtrim(char(fread(h.fid, h.ID_LENGTH, 'uchar'))'));
    b.data_length = fread(h.fid, 1, 'uint64');
    b.blocktype = fread(h.fid, 1, 'uint32');
    b.datatype = fread(h.fid, 1, 'uint32');
    b.ndims = fread(h.fid, 1, 'uint32');
    b.name = deblank(strtrim(char(fread(h.fid, string_length, 'uchar'))'));
    b.mesh_id = '';
    b.var = 0;
    b.map = 0;
    block = b;
    blocklist(n) = block;
    b.block_start = b.next_block_location;
    %fprintf('%i, bt = %u,id = %s\n',n,block.blocktype,block.id)
end
fclose(h.fid);
end