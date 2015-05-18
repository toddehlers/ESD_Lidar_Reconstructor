close all
clear all

clc
load nscanids.mat
scanID = nScanID;

Y  = [60:260];
X = 177 * ones(size(Y));

ind = [70 71] - 14;

First = scanID(ind(1)).ID;
Second = scanID(ind(2)).ID;

dloc='/Volumes/fshahzad/src/Simulations/20130129';
pFile1 = [dloc '/' First '__' Second '_PLIST.pcd'];
qFile1 = [dloc '/' First '__' Second '_QLIST.pcd'];

dt = datestr2dt(nScanID(ind(1)).FullDate,nScanID(ind(2)).FullDate);

data=pcd2Velocity(pFile1,qFile1,dt); %the results will be m/hr
d = data(:,:,4);
siz = size(d);
d=deleteoutliers(d(:),0.0005,1);
data(:,:,4) = reshape(d,siz);

P = pcd2mesh(pFile1);

[Vel1] = improfile(data(:,:,4),X,Y);
[vx] = improfile(P(:,:,1),X,Y);
[vy] = improfile(P(:,:,2),X,Y);

xPoints1 = cumsum(sqrt(power(diff(vx),2)+power(diff(vy),2)));

pFile1 = [dloc '/' First '__' Second '_PLIST0.5.pcd'];
qFile1 = [dloc '/' First '__' Second '_QLIST0.5.pcd'];

data=pcd2Velocity(pFile1,qFile1,dt); %the results will be m/hr
d = data(:,:,4);
siz = size(d);
d=deleteoutliers(d(:),0.0005,1);
data(:,:,4) = reshape(d,siz);

P = pcd2mesh(pFile1);

[Vel05] = improfile(data(:,:,4),X*2,Y*2);
[vx] = improfile(P(:,:,1),X*2,Y*2);
[vy] = improfile(P(:,:,2),X*2,Y*2);
xPoints05 = cumsum(sqrt(power(diff(vx),2)+power(diff(vy),2)));

pFile1 = [dloc '/' First '__' Second '_PLIST5.pcd'];
qFile1 = [dloc '/' First '__' Second '_QLIST5.pcd'];

data=pcd2Velocity(pFile1,qFile1,dt); %the results will be m/hr
d = data(:,:,4);
siz = size(d);
d=deleteoutliers(d(:),0.0005,1);
data(:,:,4) = reshape(d,siz);

P = pcd2mesh(pFile1);

[Vel5] = improfile(data(:,:,4),(X/10),(Y/10));
[vx] = improfile(P(:,:,1),X/10,Y/10);
[vy] = improfile(P(:,:,2),X/10,Y/10);
xPoints5 = cumsum(sqrt(power(diff(vx),2)+power(diff(vy),2)));
% 

texts.Title = 'Sensivity Analysis on Velocity Calculations for Rhone Glacier';
texts.XLabel= 'Distance';
texts.YLabel='Velocty (mm/hr)';
texts.Legend{1} ='Search radius of 0.5 m';
texts.Legend{2} ='Search radius of 1 m';
texts.Legend{3} ='Search radius of 5 m';

fig = figure('Position',[680, 841, 560, 257]);
hold on
l05 = line(xPoints05,1000*Vel05(2:end));
l1 = line(xPoints1,1000*Vel1(2:end));
l5 = line(2*xPoints5,1000*Vel5(2:end));
 
set(l05,'Color','b','LineWidth', 1,'LineStyle','-');
set(l1,'Color','r','LineWidth', 1,'LineStyle','-');
set(l5,'Color','k','LineWidth', 1,'LineStyle','-');

hTitle  = title (texts.Title);
hXLabel = xlabel(texts.XLabel);
hYLabel = ylabel(texts.YLabel); 


set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 12          );
set( hTitle                    , ...
    'FontSize'   , 14          , ...
    'FontWeight' , 'bold'      );

set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
    'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'off'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'LineWidth'   , 2         );

xlim([0, 200])
hLegend = legend([l05, l1 l5], ...
             texts.Legend{1:3});
set([hLegend, gca]             , ...
    'FontSize'   , 10           );


save = ['Fig11_' num2str(ind(1)) '.eps']
set(fig, 'PaperPositionMode', 'auto');
print('-depsc2','-r300',save)
close;
fixPSlinestyle(save,save);




