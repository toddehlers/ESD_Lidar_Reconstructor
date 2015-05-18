function fig = pcdDZVectors(fig, pFile,qFile,time1,time2,texts,dt,Xn,Yn,sp)

t1 = pcd2mesh(time1); 
t2 = pcd2mesh(time2);
dtime = t1-t2;

data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr

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

sz = sqrt(u(:,:,ii).^2 + v(:,:,ii).^2); % The length of each arrow.
nPx(:,:,ii) = u(:,:,ii)./sz;
nPy(:,:,ii) = v(:,:,ii)./sz;
nPz(:,:,ii) = w(:,:,ii)./sz;

nX   = X(1:sp:end-1,1:sp:end-1);
nY   = Y(1:sp:end-1,1:sp:end-1);
nnPx = nPx(1:sp:end-1,1:sp:end-1,ii);
nnPy = nPy(1:sp:end-1,1:sp:end-1,ii);


imagesc(1000*dtime(:,:,3))
axis image

cH = colorbar('location','SouthOutside','fontsize',14);

hold on
hst = quiver(nX, nY,nnPx,nnPy,0.5,'k'); % The .5 scales the arrows.
csl = line(Xn,Yn);

set(hst,'Color','k','LineWidth',1,'LineStyle','-');
set(csl,'Color','k','LineWidth',3,'LineStyle','-');

hTitle  = title ('');

hLegend = legend([hst], ...
    texts.Legend{1});

set( gca                       , ...
    'FontName'   , 'Helvetica' );

set([hLegend, gca]             , ...
    'FontSize'   , 11           );

bkcolor = get(gcf,'Color');
fig = esdOverLayPatch(fig, faces, verts,bkcolor);

axis off
axis tight

clBarpos = get(cH,'Position');

set(cH,'Position',[clBarpos(1)+0.095 clBarpos(2)-0.07  2*clBarpos(3)/5 clBarpos(4)])
set(hLegend,'Position',[0.05+clBarpos(1)+2*clBarpos(3)/3.5 clBarpos(2)-0.07  -0.1+clBarpos(3)/3 clBarpos(4)])

title(cH,texts.CBTitle{1} ,'FontName', 'Helvetica','FontSize', 11);

ttPos = get(hTitle,'Position');
ttPos(2) = ttPos(2) + 14;
hTitle = text(ttPos(1),ttPos(2),texts.Title);
set( hTitle                    , ...
    'FontSize'   , 14          , ...
    'FontWeight' , 'bold'      , ...
    'FontName'   , 'Helvetica');