% clear all
% % % close all
% % % clc
% % %
% clc
% dloc='/Volumes/fshahzad/src/Simulations/20121213/RAW/';
% refFile = [dloc '015_01.pcd']
% [header voldata1]= pcdReadFile(refFile);
% % % % header = pcdReadHeader(refFile);
% 
% a = 1;
% b = 8084997;
% 
% r = round(a + (b-a).*rand(1000000,1));
% 
% plotdata = voldata1(r,:);
% 
% h = surface(...
%   'XData',[plotdata(:,1) plotdata(:,1)],...
%   'YData',[plotdata(:,2) plotdata(:,2)],...
%   'ZData',[plotdata(:,3) plotdata(:,3)],...
%   'CData',[plotdata(:,4) plotdata(:,4)],...
%   'FaceColor','none',...
%   'LineStyle','none',...
%   'EdgeColor','flat',...
%   'Marker','.');
% 
% colormap('gray') 
% colorbar
% % view(-10,14)
% axis image

% plot3(,plotdata(:,2),plotdata(:,3),'')

% count=100;
% a=rand(count,3);
% figure
% hold on
% for x=1:count
% quiver3(0,0,0,a(x,1),a(x,2),a(x,3),0,'Color',[a(x,1),a(x,2),a(x,3)])
% end
% hold off
% axis equal


% clc
% % clear all
% 
% 
% dloc='../Simulations/20121213/RAW/';
% 
% % pcd = dir(dloc);
% 
% % grdFile   = [dloc pcd(4).name];
% 
% 
% for ii = 1:length(pcd2)
%     ii
%     
%     inFile   = [dloc pcd1{ii}]
%     
%     outFile   = [dloc pcd2{ii}]
%         
%     [header, voldata3] = pcdReadFile(inFile);
%     header{3} = chng;
% 
%     pcdWriteNewHeader(outFile,header,voldata3);
% 
% end

% header{3} = 'FIELDS x y z rgb

% pcd1 = {};
% pcd2 = {};
%
% kk = 1;
% for ii = 3:length(pcd)
%
%     grdFile   = [dloc pcd(ii).name];
%
%
%     header = pcdReadHeader(grdFile);
%
%
%     cl = header{3};
%
%     cl = cl(regexp(cl,'i','end'):end);
%
%     if isempty(cl)
%
%         pcd1{kk} = pcd(ii).name;
%         pcd2{kk} = strrep(pcd(ii).name, '_01', '_02')
%
% %         disp([grdFile ' is rgb image'])
%         kk = kk +1;
%     else
%
% %         disp([grdFile ' is intensity image'])
%
%     end
%
%
% end


% cutVolFile =[dloc '/045_cutvol1.pcd'];
% %
% [header, voldata1] = pcdReadFile(refFile2);
% % id = voldata1(:,3)== 0;
% % voldata1(id,1:3) = nan;
% %
% data = pcd2mesh(refFile);
% imagesc(data(:,3))
% % % rast = pcdGrid2rast(pFile);
% % % [header, voldata2] = read_pcd(volfile2);
% % % [header, voldata3] = read_pcd(volfile3);
% % %
% %
% % x = voldata1(:,1);
% % y = voldata1(:,2);
% % z = voldata1(:,3);
% % c = voldata1(:,3);
%
% % h = surface(...
% %   'XData',[x(:) x(:)],...
% %   'YData',[y(:) y(:)],...
% %   'ZData',[z(:) z(:)],...
% %   'CData',[c(:) c(:)],...
% %   'FaceColor','none',...
% %   'EdgeColor','flat',...
% %   'Marker','.');
% %
% % set(h,'LineStyle','none','Marker','.')
% %
% [X, Y,Z, DX, DY,DZ] = pcds2displacement(qFile, pFile);
% % %
% % hold on
% % quiver(X,Y,DX,DY,'k');
% % % h = surf(X,Y,Z);
% % % shading interp
% % % hold off
% % xlabel('X');
% % ylabel('Y');
% % % zlabel('Z');
% % axis image
% % % view(-1,24);


% xx(isnan(xx)) = 0;
% yy(isnan(yy)) = 0;
% zz(isnan(zz)) = 0;
%
% DX(isnan(DX)) = 0;
% DY(isnan(DY)) = 0;
% DZ(isnan(DZ)) = 0;
%
% close all
% % load wind
% clear x y z u  v w
% x(:,:,1) = xx;
% y(:,:,1) = yy;
% z(:,:,1) = zz;
%
% u(:,:,1) = DX;
% v(:,:,1) = DY;
% w(:,:,1) = DZ;
%
% x(:,:,2) = X;
% y(:,:,2) = Y;
% z(:,:,2) = Z;
%
% u(:,:,2) = DX;
% v(:,:,2) = DY;
% w(:,:,2) = DZ;
%
% h = streamslice(u,v,w,[2],[2],[2]);
% set(h,'Color','red');
% % view(3)




figure
imagesc(peaks(50));

tt = title(sprintf(strcat('abc \t','hello')));
set(tt,'Position', [25.4424 0.5 1.00005])






