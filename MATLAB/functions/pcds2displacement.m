function data = pcds2displacement(PList, QList)

data = PList - QList;




% =========== Do not delete untill done by fshahzad == this is old style
% 
% if pcdIsGridded(pcdfile1) && pcdIsGridded(pcdfile2)
%     
%     [header1, voldata1] = pcdReadFile(pcdfile1);
%     [header2, voldata2] = pcdReadFile(pcdfile2);
%     
% else
%     
%     error ('Files are not gridded so computation not possible');
%     
% end
% 
% id = voldata1(:,3)== 0;
% voldata1(id,1:3) = nan;
% 
% id = voldata2(:,3)== 0;
% voldata2(id,1:3) = nan;
% 
% [width, height] = pcdGridSize(pcdfile1);
% 
% id = voldata1(:,3)==0;
% voldata1(id,1:3) = nan;
% 
% id = voldata2(:,3)==0;
% voldata2(id,1:3) = nan;
% 
% data(:,:,1) = reshape(voldata1(:,1)-voldata2(:,1),height,width);
% data(:,:,2) = reshape(voldata1(:,2)-voldata2(:,2),height,width);
% data(:,:,3) = reshape(voldata1(:,3)-voldata2(:,3),height,width);