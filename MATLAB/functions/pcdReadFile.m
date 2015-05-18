function [header, data]= pcdReadFile(file)

if strcmp(file(end-3:end),'.pcd')
    fid = fopen(file);
else
    return;
end

% Start processing.
header = {};
data = [];

for ii = 1:1:11
    
    tline = fgetl(fid);
    header{ii} = tline;
    
end


cl = header{3};
cl = cl(regexp(cl,'FIELDS','end')+2:end);

cl = regexprep(cl,'intensity','5');
cl = regexprep(cl,'rgb','4');

cl = regexprep(cl,'x','1');
cl = regexprep(cl,'y','2');
cl = regexprep(cl,'z','3');

ncols = length(regexprep(cl,'[^\w'']',''));

data = [data; fscanf(fid, '%f')];
data = reshape(data, ncols, length(data)/ncols);

data = data';
fclose(fid);