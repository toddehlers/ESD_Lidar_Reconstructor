function pcdWriteNewHeader(fname,hdr,data)

% By Fshahzad

fileID = fopen(fname,'w');

for ii = 1:1:length(hdr)
    
    fprintf(fileID,'%s\n',hdr{ii});
    
end

% data information
fprintf(fileID,'%.6f %.6f %.6f\n',data');
fclose(fileID);

end
