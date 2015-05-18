function pcdIntensityPlot(refFile,nPts,save)

[header voldata1]= pcdReadFile(refFile);

r = round(1 + (length(voldata1)-1).*rand(nPts,1));

plotdata = voldata1(r,:);

fig = figure('Units', 'pixels', ...
    'Position', [100 100 500 475]);

h = surface(...
    'XData',[plotdata(:,1) plotdata(:,1)],...
    'YData',[plotdata(:,2) plotdata(:,2)],...
    'ZData',[plotdata(:,3) plotdata(:,3)],...
    'CData',[plotdata(:,4) plotdata(:,4)],...
    'FaceColor','none',...
    'LineStyle','none',...
    'EdgeColor','flat',...
    'Marker','.');

colormap('gray')
colorbar
% view(-10,14)
axis image

hold on

cH = colorbar('location','EastOutside','fontsize',14);

texts.Title     = 'Intensity map of Rhone Glacier ';
texts.XLabel    = 'Distance (m)';
texts.YLabel    = 'Elevation (m)';
texts.Legend{1} = 'Flow Directions';
texts.CBTitle{1}= 'Intensity';

hTitle  = title (texts.Title);

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
hold on
fig = esdOverLayPatch(fig, faces, verts,bkcolor);


if save
    
    set(fig, 'PaperPositionMode', 'auto');
    print -depsc2 -r300 Plot1221225.eps
    close;
    fixPSlinestyle('Plot1221225.eps', 'Plot1221225.eps');
    
end
