function pcdWriteFile(fname,data,width,height)

% By Fshahzad

ptLength = width*height;

% Header information

hdr{1}=sprintf('%s','# .PCD v0.7 - Point Cloud Data file format');
hdr{2}=sprintf('%s','VERSION 0.7');
hdr{3}=sprintf('%s','FIELDS x y z');
hdr{4}=sprintf('%s','SIZE 4 4 4');
hdr{5}=sprintf('%s','TYPE F F F');
hdr{6}=sprintf('%s','COUNT 1 1 1');
hdr{7}=sprintf('WIDTH %d',width);
hdr{8}=sprintf('HEIGHT %d',height);
hdr{9}=sprintf('%s','VIEWPOINT 0 0 0 1 0 0 0');
hdr{10} = sprintf('POINTS %d',ptLength);
hdr{11}=sprintf('%s','DATA ascii');

fileID = fopen(fname,'w');

for ii = 1:1:length(hdr)
    
    fprintf(fileID,'%s\n',hdr{ii});
    
end

% data information
fprintf(fileID,'%.6f %.6f %.6f\n',data');
fclose(fileID);

end
