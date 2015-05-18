function [width, height] = pcdGridSize(file)


if strcmp(file(end-3:end),'.pcd')
    header = pcdReadHeader(file);
else
    error (['File name' file ' is not correct']);
%     return;
end


wd = header{7};
hg = header{8};

width = str2double(wd(regexp(wd,'WIDTH','end')+2:end));
height = str2double(hg(regexp(hg,'HEIGHT','end')+2:end));