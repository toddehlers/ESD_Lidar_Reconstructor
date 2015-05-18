function fig = pcdCrossSectionVelocity(fig, pFile,qFile,dt,texts,X,Y)

data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr

d = data(:,:,4);
siz = size(d);

d=deleteoutliers(d(:),0.0005,1);
d = reshape(d,siz);
data(:,:,4) = d*1000;


[CX1,CY1,CP] = improfile(data(:,:,4),X,Y);
CP=fixgaps(CP,'Cubic');

xPoints=cumsum(sqrt(power(diff(CX1),2)+power(diff(CY1),2)));


figure(fig)

hVals1   = line(xPoints,(CP(2:end)));

set(hVals1,'Color','k','LineWidth', 1,'LineStyle','-');
     

hTitle  = title (texts.Title);
hXLabel = xlabel(texts.XLabel);
hYLabel = ylabel(texts.YLabel);
%  
% hLegend = legend([hVals1], ...
%              texts.Legend{1});

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
xlim([1 length(xPoints)])