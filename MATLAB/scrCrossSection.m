% close all
% clear all
% 
% % dloc='/Users/fshahzad/Desktop/exch/data';
% % refFile = [dloc '/045_ref.pcd'];
% % pFile =[dloc '/045_048_Plist1.pcd'];
% % qFile =[dloc '/045_048_Qlist.pcd'];
% 
% clc
% 
dloc='/Volumes/fshahzad/src/Simulations/20121213/REF/';
grdFile   = [dloc '100_01__103_01_DIFF.pcd']
% minFile   = [dloc '100_01_MAX.pcd']
% maxFile   = [dloc '100_01_MIN.pcd']
 
% % [width, height] = pcdGridSize(grdFile)
% 
% % [header, maxRAST] = pcdReadFile(maxFile);
% % % 

[h volRAST] = pcdReadFile(grdFile);
volRAST = reshape(volRAST(:,3),size(maxRAST1));
volRast1=inpaint_nans(volRAST,5);

 


% fig = pcdVelocityCSEPS(xPoints,C1(2:end),texts)
% 
% set(fig, 'PaperPositionMode', 'auto');
% print -deps2 -r300 VelcotyCS.eps
% % close;
% fixPSlinestyle('VelcotyCS.eps', 'VelcotyCS.eps');

% figure
% imagesc(data(:,:,4))
% axis image
% % 
% % 
% [X, Y] = ginput(3);
% hold on
% plot(X,Y,'-')