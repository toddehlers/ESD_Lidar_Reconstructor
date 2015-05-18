function fig = pcdFlowStreamLines(fig, pFile,qFile,dt,texts,flt,Xn,Yn,save)

data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr

d = data(:,:,4);
siz = size(d);

d=deleteoutliers(d(:),flt,1);
d = reshape(d,siz);
data(:,:,4) = d*1000;


load boundary.mat;

u   = [];
v   = [];
w   = [];
ind = 2;


[rr cr dr] = size(data);
[ru cu du] = size(data);

%
[X,Y] = meshgrid(1:ind*cr/cu:cr,1:ind*rr/ru:rr);
%
ii =1;

u(:,:,ii) =data(1:ind:end,1:ind:end,1);
v(:,:,ii) =data(1:ind:end,1:ind:end,2);
w(:,:,ii) =data(1:ind:end,1:ind:end,3);
%

% fig = figure('Units', 'pixels', ...
%     'Position', [100 100 500 475]);
imagesc(data(:,:,4))
axis image

cH = colorbar('location','SouthOutside','fontsize',14);

hold on
hst = streamslice(X,Y,u(:,:,ii),v(:,:,ii),3,'cubic');
csl = line(Xn,Yn);

set(hst,'Color','k','LineWidth',1,'LineStyle','-');
set(csl,'Color','k','LineWidth',2,'LineStyle','--');

hTitle  = title (texts.Title);

hLegend = legend([hst], ...
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
fig = esdOverLayPatch(fig, faces, verts,bkcolor);

axis off
axis tight

clBarpos = get(cH,'Position');

set(cH,'Position',[clBarpos(1)+0.095 clBarpos(2)-0.07  2*clBarpos(3)/5 clBarpos(4)])
set(hLegend,'Position',[0.05+clBarpos(1)+2*clBarpos(3)/3.5 clBarpos(2)-0.07  -0.1+clBarpos(3)/3 clBarpos(4)])

title(cH,texts.CBTitle{1} ,'FontName', 'Helvetica','FontSize', 11)

if ~isempty(save)
   
    set(fig, 'PaperPositionMode', 'auto');
    print('-depsc2','-r300',save)
    close;
    fixPSlinestyle(save,save);

end