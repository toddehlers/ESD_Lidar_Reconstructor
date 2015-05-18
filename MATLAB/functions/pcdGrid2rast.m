function rast = pcdGrid2rast(pcdfile,col)

if ~pcdIsGridded(pcdfile)

    error ('not a gridded PCD file');

else
    
    [header, voldata1] = pcdReadFile(pcdfile);
    
    [width, height] = pcdGridSize(pcdfile);

    id = voldata1(:,col)==0;
    voldata1(id,1:3) = nan;
    
    
    rast = reshape(voldata1(:,col),height,width);
    rast = flipud(rast);
    
end
% For huge datasets, the following can be used with file handling
% rast = [];
% sind = 0;
% enind = 0;

% for ii = height:height:width*height
%
%     out = [out ; voldata1(sind+1:ii,3)'];
%     sind = ii;
%
% end