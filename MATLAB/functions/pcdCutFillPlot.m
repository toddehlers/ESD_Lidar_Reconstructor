% function pcdCutFillPlot(refFile,nPts,save)



save = 0;
nPts = 700000;

% [header voldata1]= pcdReadFile(refFile);

r = round(1 + (length(voldata1)-1).*rand(nPts,1));

plotdata = voldata1(r,:);

fig = figure('Units', 'pixels', ...
    'Position', [100 100 500 475]);

h = surface(...
    'XData',[plotdata(:,1) plotdata(:,1)],...
    'YData',[plotdata(:,2) plotdata(:,2)],...
    'ZData',[plotdata(:,3) plotdata(:,3)],...
    'CData',[plotdata(:,3) plotdata(:,3)],...
    'FaceColor','none',...
    'LineStyle','none',...
    'EdgeColor','flat',...
    'Marker','.');

colorbar
% view(-10,14)
axis image

hold on

cH = colorbar('location','EastOutside','fontsize',14);

texts.Title     = 'Volume Differences bw 11:AM and 14:00 PM on 20120810 ';
texts.XLabel    = 'Distance (m)';
texts.YLabel    = 'Elevation (m)';
texts.Legend{1} = 'Flow Directions';
texts.CBTitle{1}= 'Volume change (m^3)';

hTitle  = title (texts.Title);

set(h, 'Markersize',6);

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle], ...
    'FontName'   , 'Helvetica');
set( hTitle                    , ...
    'FontSize'   , 14          , ...
    'FontWeight' , 'bold'      );

bkcolor = get(gcf,'Color');

set(gca,'ytick',[],'xtick',[],'XColor',[1 1 1],'YColor',[1 1 1]) ;
ylabel(cH,texts.CBTitle{1} ,'FontName', 'Helvetica','FontSize', 12)

load boundary.mat;
bkcolor = get(gcf,'Color')

% 
% fig = esdOverLayPatch(fig, faces, verts,bkcolor);
% 
% 
% if save
    
    set(fig, 'PaperPositionMode', 'auto');
    print -depsc2 -r300 Diff100103.eps
%     close;
    fixPSlinestyle('Diff100103.eps', 'Diff100103.eps');
%     
% end
