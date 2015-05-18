% clear all
% 
% dloc='/Volumes/fshahzad/src/ESD_Reconstructor/DownSamplePCD/build/';
% clc
% refFile1 = [dloc '045_ref.pcd']
% refFile2 = [dloc '045_ref_80.pcd']
% 
% [header, voldata3] = pcdReadFile(refFile2);
% 
% x = voldata3(:,1);
% y = voldata3(:,2);
% z = voldata3(:,3);
% c = voldata3(:,3);
% 
% figure
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

verts = [0.9444    1.4700;
    1.0000  290.0000;
  357.0000  290.0000;
  357.0000    1.0000;
    0.9444    1.4700;
   64.7489   12.4633;
  128.9844   23.4567;
  356   63;
  293  290;
   83  288];

figure;imagesc(data(:,:,3)); axis image
color = 'r'
% figure;
hold on
obdr = plot(verts(faces(1:5),1),verts(faces(1:5),2));
set(obdr,'Color',color,'LineWidth',3,'LineStyle','-');

p = patch('Faces',faces,'Vertices',verts);
set(p,'FaceColor',color,'EdgeColor',color,'MarkerEdgeColor',color, ...
    'MarkerFaceColor',color,'MarkerSize',3)
hold on

bdr = plot(verts(faces(6:end),1),verts(faces(6:end),2),'k-');
set(bdr,'Color','k','LineWidth',2,'LineStyle','-');

set(gca,'ydir','reverse');

hold on
for ii = 1:1:length(verts)
    text(verts(ii,1),verts(ii,2),num2str(ii),'FontSize'   , 16)
end

