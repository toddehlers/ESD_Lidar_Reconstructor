% clear all
% dloc='/Volumes/fshahzad/src/ESD_Reconstructor/CleanPCD/build/';
%
% refFile1 = [dloc '/017_01.pcd'];
% refFile2 = [dloc '/017_01_REF.pcd'];
%
% [header, voldata3] = pcdReadFile(refFile2);
%
% % [header1{:} header2{:}]

% dloc='/Volumes/fshahzad/src/ESD_Reconstructor/bin/';
% % refFile1 = [dloc '/058_01_REF_GRID.pcd'];
% refFile = [dloc '/045_ref_GRID.pcd'];
% pFile =[dloc '/45_01__48_01_PLIST.pcd'];
% qFile =[dloc '/45_01__48_01_QLIST.pcd'];
% minFile =[dloc '/045_01_MIN.pcd'];
% maxFile =[dloc '/045_01_MAX.pcd'];
% volFile =[dloc '/45_01__48_01_DIFF.pcd'];


% if (width==length(voldata3)/4)
%
%     disp(grdFile);
%
% end


% [width, height] = pcdGridSize(grdFile);

% [header, voldata3] = pcdReadFile(grdFile);

% rast = pcdGrid2rast(minFile,3)
% %
% imagesc(rast)

% x = voldata3(:,1);
% y = voldata3(:,2);
% z = voldata3(:,3);
% c = voldata3(:,3);
%
% h = surface(...
%   'XData',[x(:) x(:)],...
%   'YData',[y(:) y(:)],...
%   'ZData',[z(:) z(:)],...
%   'CData',[c(:) c(:)],...
%   'FaceColor','none',...
%   'EdgeColor','flat',...
%   'Marker','.');
%
% set(h,'LineStyle','none','Marker','.')