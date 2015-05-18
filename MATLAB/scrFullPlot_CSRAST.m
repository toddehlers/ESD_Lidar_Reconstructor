% close all
clear all

clc
load nscanids.mat
scanID = nScanID;
Y  =    [60:260];
X = 177 * ones(size(Y));

% ind = [41:55];
% ind = [17 24 35 46 56 68 78 88 102 112 123 135 146] - 14
% ind = [17 35 56 78 102 123 146] - 14

ind = [81 82 83] - 14;

for ii = 1:length(ind)-2
    ii
    First = scanID(ind(ii)).ID;
    Second = scanID(ind(ii+1)).ID;
    Third = scanID(ind(ii+2)).ID;
    
    dloc='/Volumes/fshahzad/src/Simulations/20130128/';
    pFile = [dloc '' First '__' Second '_PLIST.pcd']
    qFile = [dloc '' First '__' Second '_QLIST.pcd']
    
    time1 = [dloc '' First '__' Second '_PLIST.pcd'];
    time2 = [dloc '' Second '__' Third '_PLIST.pcd'];
    
    
    super_title = ['Rhone glacier surface velocities between ', datestr(nScanID(ind(ii)).FullDate,0), ...
        ' and ',datestr(nScanID(ind(ii+1)).FullDate,13)];
    
    dt = datestr2dt(nScanID(ind(ii)).FullDate,nScanID(ind(ii+1)).FullDate);
    
    fig = figure('Units', 'pixels','Position', [1 1 1175 580]);
    
    h_CS1  = subplot(2,2,2);
    set(h_CS1,'Position',[0.57 0.57 0.4 0.3]);
    %
    veltexts.Title     = 'Velocity Cross Section';
    veltexts.XLabel    = 'Distance (m)';
    veltexts.YLabel    = 'Velocity (mm/hr)';
    veltexts.Legend{1} = 'Velocity (mm/hr)';
    
    fig = pcdCrossSectionVelocity(fig, pFile,qFile,dt,veltexts,X,Y);
    
    h_CS2  = subplot(2,2,4);
    set(h_CS2,'Position',[0.57 0.10 0.4 0.3]);
    %
    topotexts.Title     = 'Topograhic Cross Section';
    topotexts.XLabel    = 'Distance (m)';
    topotexts.YLabel    = 'Topographic Difference (mm)';
    topotexts.Legend{1} = 'Topographic Difference (mm)';
    topotexts.Legend{2} = 'Topography Time 2';
    
    fig = pcdCrossSectionTopography(fig, time1,time2,topotexts,X,Y);
    
    texts.Title = '';
    texts.Legend{1} = 'Flow Directions';
    texts.CBTitle{1} = 'Velocity (mm/hr)';
    flt = 0.0005;
    %
    h_rast = subplot(2,2,[1 3]);
    set(h_rast,	'Position',[0.02 0.1 0.5 0.86])
    fig = pcdFlowVectors(fig, pFile,qFile,dt,texts,flt,X,Y,5);
    
    c1 = text(174.7428,52.4489,'X');
    set( c1                    , ...
        'FontSize'   , 16      , ...
        'FontWeight' , 'bold'  , ...
        'FontName'   , 'Helvetica');
    
    c2 = text(174.7428,266.4489,'Y');
    set( c2                    , ...
        'FontSize'   , 16      , ...
        'FontWeight' , 'bold'  , ...
        'FontName'   , 'Helvetica');
    
    
    sTitle = text(100,0,super_title);
    set( sTitle                    , ...
        'FontSize'   , 16          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    a = text(-7.7104, 22.04,'(a)');
    set( a                    , ...
        'FontSize'   , 18          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    b = text(362.1022,29.3382,'(b)');
    set( b                    , ...
        'FontSize'   , 16          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    c = text(362.1022,188.6806,'(c)');
    set( c                    , ...
        'FontSize'   , 16          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    cs_X = text(395,150,'X');
    set( cs_X                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    cs_Y = text(675,150,'Y');
    set( cs_Y                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    cs_X = text(395,317,'X');
    set( cs_X                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    cs_Y = text(675,317,'Y');
    set( cs_Y                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    scl = line(300+[1 50],[1 1]+35);
    set(scl,'Color',[.3 .3 .3] ,'LineWidth',3,'LineStyle','-');
    
    scale2 = text(315,43,'50 m');
    set( scale2                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    
        save = strcat(First,'_',Second,'_Half_Hour.eps');
    
        if ~isempty(save)
    
            set(fig, 'PaperPositionMode', 'auto');
            print('-depsc2','-r300',save)
            close;
            fixPSlinestyle(save,save);
    
        end
    
end

% scale = text(315,30,'Scale');
% set( scale                      , ...
%     'FontSize'   , 14          , ...
%     'FontWeight' , 'bold'      , ...
%     'Color'      , [.3 .3 .3]  , ...
%     'FontName'   , 'Helvetica');


