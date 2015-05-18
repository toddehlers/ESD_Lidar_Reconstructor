function data = pcd2mesh(pcdfile)

if ~pcdIsGridded(pcdfile)
    
    error ('not a gridded PCD file');
    
else
    
    [header, voldata1] = pcdReadFile(pcdfile);
    
    [width, height] = pcdGridSize(pcdfile);
    
    id = voldata1(:,3)==0;
    voldata1(id,3) = nan;
    
    
    data(:,:,1) = reshape(voldata1(:,1),height,width);
    data(:,:,1) = flipud(data(:,:,1));
    
    data(:,:,2) = reshape(voldata1(:,2),height,width);
    data(:,:,2) = flipud(data(:,:,2));
    
    data(:,:,3) = reshape(voldata1(:,3),height,width);
    data(:,:,3) = flipud(data(:,:,3));
    
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