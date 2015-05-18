function header = pcdReadHeader(file)

if strcmp(file(end-3:end),'.pcd')
    fid = fopen(file);
else
    error (['File name' file ' is not correct']);
end

% Start processing.
header = {};

for ii = 1:1:10
    
    tline = fgetl(fid);
    header{ii} = tline;
    
end

fclose(fid);