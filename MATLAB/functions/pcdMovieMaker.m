% clear all
dloc='/Volumes/fshahzad/src/Simulations/20121211/';
u   = [];
v   = [];
w   = [];

ind = 1;
sp = 15;


% refFile = [dloc 'RAW/015_01.pcd'];

scanOffset = 0;

% for ii = [100:137 140:148]
% for ii = 100
    
    ii = 100;
    pFile = strcat(dloc, num2str(ii+scanOffset), '_01__',num2str(ii+2+1),'_01_PLIST.pcd')
    qFile = strcat(dloc, num2str(ii+scanOffset), '_01__',num2str(ii+2+1),'_01_QLIST.pcd')
    data=pcd2Velocity(pFile,qFile,2); %dt = 2hr so the results will be m/hr
    ii = 1;
    d = data(:,:,4);
    siz = size(d)
    
    d=deleteoutliers(d(:),0.000005,1);
    d = reshape(d,siz);
    data(:,:,4) = d;

    [rr cr dr] = size(data);
    
    u(:,:,ii) =data(1:ind:end,1:ind:end,1);
    v(:,:,ii) =data(1:ind:end,1:ind:end,2);
    w(:,:,ii) =data(1:ind:end,1:ind:end,3);
    
    sz = sqrt(u(:,:,ii).^2 + v(:,:,ii).^2); % The length of each arrow.
    nPx(:,:,ii) = u(:,:,ii)./sz;
    nPy(:,:,ii) = v(:,:,ii)./sz;
    nPz(:,:,ii) = w(:,:,ii)./sz;
    
% end




    
    load('base_int.mat')
    
    minxGrd = min(plotdata(:,1));
    minyGrd = min(plotdata(:,2));
    
    plotdata(:,1) =  plotdata(:,1) -minxGrd;
    plotdata(:,2) =  plotdata(:,2) -minyGrd;
    
    maxxGrd = max(plotdata(:,1));
    maxyGrd = max(plotdata(:,2));
    
    [r,c,b] = size(data);
    
    [X,Y] = meshgrid(1:maxxGrd/c:maxxGrd,1:maxyGrd/r:maxyGrd);

    
nX   = X(1:sp:end,1:sp:end);
nY   = Y(1:sp:end,1:sp:end);
nnPx = nPx(1:sp:end,1:sp:end,ii);
nnPy = nPy(1:sp:end,1:sp:end,ii);
   
% texts.XLabel    = 'Distance (m)';
% texts.YLabel    = 'Elevation (m)';
% texts.CBTitle{1} = 'Velocity (m/hr)';

% xlim([1 cr])
% ylim([1 rr])

figure

ha = quiver(nX, nY,nnPx,nnPy,0.5,'k'); % The .5 scales the arrows.

texts.Title     = 'Surface Velcities between 11:00AM and 1:00 PM on 20120810 ';
texts.Legend{1} = 'Flow Directions';

set(ha,'Color','k','LineWidth',1,'LineStyle','-');

hTitle  = title (texts.Title);

hLegend = legend([ha], ...
    texts.Legend{1});

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle], ...
    'FontName'   , 'Helvetica');
set([hLegend, gca]             , ...
    'FontSize'   , 11           );
set( hTitle                    , ...
    'FontSize'   , 14          , ...
    'FontWeight' , 'bold'      );

bkcolor = get(gcf,'Color');
% fig = esdOverLayPatch(fig, faces, verts,bkcolor);
% 
% axis off
% axis tight
% % 
% clBarpos = get(cH,'Position');
% % 
% set(cH,'Position',[clBarpos(1) clBarpos(2)-0.07  2*clBarpos(3)/3 clBarpos(4)])
% set(hLegend,'Position',[0.06+clBarpos(1)+2*clBarpos(3)/3 clBarpos(2)-0.07  -0.1+clBarpos(3)/3 clBarpos(4)])
% % 
% title(cH,texts.CBTitle{1} ,'FontName', 'Helvetica','FontSize', 11)
% % 
axis image off
set(gca,'ydir','revers');
% 
% 
% if ~isempty(save)
%    
    set(gcf, 'PaperPositionMode', 'auto');
    print('-depsc2','-r300','FlowDirection100103_15.eps')
%     close;
    fixPSlinestyle('FlowDirection100103_15.eps','FlowDirection100103_15.eps');
% 
% end
