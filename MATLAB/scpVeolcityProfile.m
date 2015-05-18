close all
clear all

clc
load nscanids.mat
scanID = nScanID;

ind = [70:71]-14;

Vavg = [];
dzAvg = [];

ii = 1;
First = scanID(ind(ii)).ID;
Second = scanID(ind(ii+1)).ID;

dloc='/Volumes/fshahzad/src/Simulations/20130201';

scl = {'0.5','1.0','5.0'}
fmt = {'b', 'k', 'r'}
base = [];

subplot(2,1,1)

for kk = 1:length(scl)
    
    pFile = strcat(dloc, '/', First, '__', Second, '_PLIST',scl{kk},'.pcd');
    qFile = strcat(dloc, '/', First, '__', Second, '_QLIST',scl{kk},'.pcd');
    
    
    dt = datestr2dt(nScanID(ind(ii)).FullDate,nScanID(ind(ii+1)).FullDate)
    
    data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr
    
    % max(data
    d = data(:,:,4);
    siz = size(d);
    
    d=deleteoutliers(d(:),0.0005,1);
    data(:,:,4) = reshape(d,siz);
    
    P = pcd2mesh(pFile);
    
    vx = mean(P(:,:,1),2);
    vy =mean(P(:,:,2),2);
    
    xPoints1 = cumsum(sqrt(power(diff(vx),2)+power(diff(vy),2)));
    
    Vavg = mean(data(:,:,4),2);
    base = Vavg;
    
    mn_val=fixgaps(Vavg,'cubic')*1000;
    hold on
    h{kk} = line(xPoints1,mn_val(2:end))
    
end
texts.Title = ['(A) Surface velocities between ', datestr(nScanID(ind(ii)).FullDate,0), ...
        ' and ',datestr(nScanID(ind(ii+1)).FullDate,13)];
    texts.XLabel= 'Distance (m)';
texts.YLabel='Average Velocity (mm/hr)';

set(h{1}, 'Color','r','LineWidth', 1,'LineStyle','-','MarkerSize',5,'MarkerEdgeColor' , [.2 .2 .2]  ,'MarkerFaceColor' , [.7 .7 .7]  );
set(h{2}, 'Color', [0 .5 0], 'LineWidth', 1,'LineStyle','-','MarkerSize',5,'MarkerEdgeColor' , [.2 .2 .2]  ,'MarkerFaceColor' , [.7 .7 .7]  );
set(h{3}, 'Color', 'k', 'LineWidth', 1,'LineStyle','-','MarkerSize',5,'MarkerEdgeColor' , [.2 .2 .2]  ,'MarkerFaceColor' , [.7 .7 .7]  );
  
hTitle  = title (texts.Title);
hXLabel = xlabel(texts.XLabel);
hYLabel = ylabel(texts.YLabel);
%
hLegend = legend([h{1};h{2};h{3}], ...
             [strcat(scl{1},' m');strcat(scl{2},' m');strcat(scl{3},' m')]);
 set(hLegend,'orientation','horizontal')
 
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
% set([hLegend, gca]             , ...
%     'FontSize'   , 10           );
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
axis tight

save = 'Fig10.eps'
set(gcf, 'PaperPositionMode', 'auto');
print('-depsc2','-r300',save)
close;
fixPSlinestyle(save,save);