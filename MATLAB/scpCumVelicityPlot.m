close all
clear all

clc
load nscanids.mat
scanID = nScanID;

X = 120 * [1     1     1     1     1     1     1     1     1     1     1     1     1     1 ];
Y  =    [40    50    60    70    80    90   100   110   120   130   140   150   160   170  ];

% ind = [41:55];
% ind = [17 24 35 46 56 68 78 88 102 112 123 135 146] - 14
% ind = [17 35 56 78 102 123 146] - 14

ind = [20:24]-14;

Vavg = [];
dzAvg = [];

for ii = 1:length(ind)-2
    ii
    First = scanID(ind(ii)).ID;
    Second = scanID(ind(ii+1)).ID;
    Third = scanID(ind(ii+2)).ID;
    
    try
        dloc='/Volumes/fshahzad/src/Simulations/20121213/';
        pFile = [dloc 'DIFF/' First '__' Second '_PLIST.pcd'];
        qFile = [dloc 'DIFF/' First '__' Second '_QLIST.pcd'];
        
        time1 = [dloc 'DIFF/' First '__' Second '_PLIST.pcd'];
        time2 = [dloc 'DIFF/' Second '__' Third '_PLIST.pcd'];
        
        dt = datestr2dt(nScanID(ind(ii)).FullDate,nScanID(ind(ii+1)).FullDate);
        
        data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr
        
        d = data(:,:,4);
        siz = size(d);
        
        d=deleteoutliers(d(:),0.0005,1);
        data(:,:,4) = reshape(d,siz);
        
        
        [CX1,CY1,CP] = improfile(data(:,:,4),X,Y);
        
        Vavg = [Vavg;  mean(CP)];
        
        
        P = pcd2mesh(time1);
        Q = pcd2mesh(time2);
        
        [CX1,CY1,CP] = improfile(P(:,:,3),X,Y);
        [CX1,CY1,CQ] = improfile(Q(:,:,3),X,Y);
        
        if size(P) == size(Q)
            dzAvg = [dzAvg; str2double(nScanID(ii).Date) mean(CP(2:end)-CQ(2:end))];
        else
            dzAvg = [dzAvg; str2double(nScanID(ii).Date) NaN];
        end
        
    catch
        disp(First);
    end
end

% mn_val=fixgaps(Vavg,'cubic')*1000
% 
% 
% fig = figure
% subplot(2,1,1)
% 
% typID = 2;
% 
% % data_type = station_data(1).Data(typID).Type;
% % time = station_data(1).Time;
% % date = station_data(1).Date;
% % mn_val = mean([station_data(1).Data(typID).Value station_data(2).Data(typID).Value station_data(3).Data(typID).Value],2);
% 
% 
% texts.Title = 'Mean Velocity for Rhone Glacier';
% texts.XLabel= 'Time';
% texts.YLabel='Mean Velocty (mm/hr)';
% texts.Legend ='Mean Velocty (mm/hr)';
% 
% hVals1   = line([1:length(mn_val)],mn_val);
% 
% set(hVals1,'Color','k','LineWidth', 1,'LineStyle','-');
% 
% hTitle  = title (texts.Title);
% hXLabel = xlabel(texts.XLabel);
% hYLabel = ylabel(texts.YLabel);
% 
% set( gca                       , ...
%     'FontName'   , 'Helvetica' );
% set([hTitle, hXLabel, hYLabel], ...
%     'FontName'   , 'Helvetica');
% 
% set([hXLabel, hYLabel]  , ...
%     'FontSize'   , 12          );
% set( hTitle                    , ...
%     'FontSize'   , 14          , ...
%     'FontWeight' , 'bold'      );
% 
% set(gca, ...
%     'Box'         , 'off'     , ...
%     'TickDir'     , 'out'     , ...
%     'TickLength'  , [.02 .02] , ...
%     'XMinorTick'  , 'on'      , ...
%     'YMinorTick'  , 'on'      , ...
%     'YGrid'       , 'off'      , ...
%     'XColor'      , [.3 .3 .3], ...
%     'YColor'      , [.3 .3 .3], ...
%     'LineWidth'   , 2         );
% xlim([0, 122])
% 
% subplot(2,1,2)
% 
% typID = 1;
% 
% mn_val=fixgaps(dzAvg,'cubic')*100
% % mn_val = dzAvg;
% 
% texts.Title = 'Mean Elevation change in Rhone Glacier';
% texts.XLabel= 'Time';
% texts.YLabel='Elevation Difference (mm)';
% texts.Legend ='Elevation Difference (mm)';
% 
% 
% hVals1   = line([1:length(mn_val)],mn_val);
% 
% set(hVals1,'Color','k','LineWidth', 1,'LineStyle','-');
% 
% hTitle  = title (texts.Title);
% hXLabel = xlabel(texts.XLabel);
% hYLabel = ylabel(texts.YLabel);
% %
% % hLegend = legend([hVals1], ...
% %              texts.Legend);
% 
% set( gca                       , ...
%     'FontName'   , 'Helvetica' );
% set([hTitle, hXLabel, hYLabel], ...
%     'FontName'   , 'Helvetica');
% % set([hLegend, gca]             , ...
% %     'FontSize'   , 10           );
% set([hXLabel, hYLabel]  , ...
%     'FontSize'   , 12          );
% set( hTitle                    , ...
%     'FontSize'   , 14          , ...
%     'FontWeight' , 'bold'      );
% 
% set(gca, ...
%     'Box'         , 'off'     , ...
%     'TickDir'     , 'out'     , ...
%     'TickLength'  , [.02 .02] , ...
%     'XMinorTick'  , 'on'      , ...
%     'YMinorTick'  , 'on'      , ...
%     'YGrid'       , 'off'      , ...
%     'XColor'      , [.3 .3 .3], ...
%     'YColor'      , [.3 .3 .3], ...
%     'LineWidth'   , 2         );
% xlim([0, 122])
% 
% save = 'Fig9.eps'
% set(fig, 'PaperPositionMode', 'auto');
% print('-depsc2','-r300',save)
% close;
% fixPSlinestyle(save,save);
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
