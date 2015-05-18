function fig = pcdVectorsBbox(fig, pFile,qFile,dt,texts,flt,Xn,Yn,sp,bboxx,bboxy)

data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr

d = data(:,:,3);
siz = size(d);

d=deleteoutliers(d(:),flt,1);
d = reshape(d,siz);
data(:,:,3) = d*1000;

data = data(bboxy(1):bboxy(2),bboxy(1):bboxy(2),:);


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

sz = sqrt(u(:,:,ii).^2 + v(:,:,ii).^2); % The length of each arrow.
nPx(:,:,ii) = u(:,:,ii)./sz;
nPy(:,:,ii) = v(:,:,ii)./sz;
nPz(:,:,ii) = w(:,:,ii)./sz;

nX   = X(1:sp:end-1,1:sp:end-1);
nY   = Y(1:sp:end-1,1:sp:end-1);
nnPx = nPx(1:sp:end-1,1:sp:end-1,ii);
nnPy = nPy(1:sp:end-1,1:sp:end-1,ii);


imagesc(data(:,:,3))
axis image

cH = colorbar('location','SouthOutside','fontsize',14);

hold on
hst = quiver(nX, nY,nnPx,nnPy,0.5,'k'); % The .5 scales the arrows.

set(hst,'Color','k','LineWidth',1,'LineStyle','-');

hTitle  = title (texts.Title);

hLegend = legend([hst], ...
    texts.Legend{1});

set( gca                       , ...
    'FontName'   , 'Helvetica' );

set([hLegend, gca]             , ...
    'FontSize'   , 11           );

axis off
axis tight

title(cH,texts.CBTitle{1} ,'FontName', 'Helvetica','FontSize', 11);

ttPos = get(hTitle,'Position');
ttPos(2) = ttPos(2) + 14;
% hTitle = text(ttPos(1),ttPos(2),texts.Title);
set( hTitle                    , ...
    'FontSize'   , 14          , ...
    'FontWeight' , 'bold'      , ...
    'FontName'   , 'Helvetica');