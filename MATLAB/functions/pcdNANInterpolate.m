% clear all
% close all
% clc
% 
% dloc='/Users/fshahzad/Desktop/exch/data/';
% 
% pFile =[dloc '045_046/045046_PLIST1.pcd'];
% qFile =[dloc '045_046/045046_QLIST1.pcd'];
% refFile =[dloc '045_046/045_ref_gridded.pcd'];
% 
% P = pcd2mesh(pFile); Q = pcd2mesh(qFile);
% data4546 = pcds2displacement(P, Q);
% 
% 
% u(:,:,1) = data4546(:,:,1);
% v(:,:,1) = data4546(:,:,2);
% w(:,:,1) = inpaint_nans(data4546(:,:,3),5);
% 
% x(:,:,1) = P(:,:,1);
% y(:,:,1) = P(:,:,2);
% z(:,:,1) = inpaint_nans(P(:,:,3),5);
% 
% pFile =[dloc '046_047/046047_PLIST1.pcd'];
% qFile =[dloc '046_047/046047_QLIST1.pcd'];
% 
% P = pcd2mesh(pFile); Q = pcd2mesh(qFile);
% data4647 = pcds2displacement(P, Q);
% 
% 
% u(:,:,2) = data4647(:,:,1);
% v(:,:,2) = data4647(:,:,2);
% w(:,:,2) = inpaint_nans(data4647(:,:,3),5);
% 
% x(:,:,2) = P(:,:,1);
% y(:,:,2) = P(:,:,2);
% z(:,:,2) = inpaint_nans(P(:,:,3),5);
% 
% rast = pcdGrid2rast(refFile,3);
% [rr cr dr] = size(rast);
% 
% [ru cu du]=size(u);
% 
% 
% [X,Y] = meshgrid(1:cr/cu:cr,1:rr/ru:rr);
% 
% rast = inpaint_nans(rast,5);

figure
imagesc(rast)
axis image
hold on
h = streamslice(X,Y,u(:,:,1),v(:,:,1),1);
set(h, 'color', 'k')






% % % % [header, voldata2] = read_pcd(volfile2);
% % % % [header, voldata3] = read_pcd(volfile3);
% % % %
% % %
% % % x = voldata1(:,1);
% % % y = voldata1(:,2);
% % % z = voldata1(:,3);
% % % c = voldata1(:,3);
% %
% % % h = surface(...
% % %   'XData',[x(:) x(:)],...
% % %   'YData',[y(:) y(:)],...
% % %   'ZData',[z(:) z(:)],...
% % %   'CData',[c(:) c(:)],...
% % %   'FaceColor','none',...
% % %   'EdgeColor','flat',...
% % %   'Marker','.');
% % %
% % % set(h,'LineStyle','none','Marker','.')
% % %
% [X, Y,Z, DX, DY,DZ] = pcds2displacement(qFile, pFile);
% % % %
% % % hold on
% % % quiver(X,Y,DX,DY,'k');
% % % % h = surf(X,Y,Z);
% % % % shading interp
% % % % hold off
% % % xlabel('X');
% % % ylabel('Y');
% % % % zlabel('Z');
% % % axis image
% % % % view(-1,24);

