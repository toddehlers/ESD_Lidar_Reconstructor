close all
clc
load scanids.mat

X = [133.4839  123.0645  115.3871  108.8065  102.2258];
Y = [33.6842   77.9298  122.1754  157.3450  184.0058];

ind = [49:55];

for ii = 1:length(ind)-2
    
    First = scanID(ind(ii)).ID;
    Second = scanID(ind(ii+1)).ID;
    Third = scanID(ind(ii+2)).ID;
    
    dloc='/Volumes/fshahzad/src/Simulations/20121213/';
    pFile = [dloc 'DIFF/' First '__' Second '_PLIST.pcd'];
    qFile = [dloc 'DIFF/' First '__' Second '_QLIST.pcd'];
    
    time1 = [dloc 'DIFF/' First '__' Second '_PLIST.pcd'];
    time2 = [dloc 'DIFF/' Second '__' Third '_PLIST.pcd'];
    
    
    super_title = ['Rhone glacier surface velocities between ', datestr(nScanID(ind(ii)).FullDate,0), ...
        ' and ',datestr(nScanID(ind(ii+1)).FullDate,13)];
    
    dt = datestr2dt(nScanID(ind(ii)).FullDate,nScanID(ind(ii+1)).FullDate);
        
    fig = figure('Units', 'pixels','Position', [1 1 1175 580]);
    
    h_CS1  = subplot(2,2,2);
    set(h_CS1,'Position',[0.57 0.57 0.4 0.3]);
    %
    veltexts.Title     = 'Displacement component along Z-Direction';
    veltexts.XLabel    = 'Distance (m)';
    veltexts.YLabel    = 'dz (mm)';
    veltexts.Legend{1} = 'dz (mm)';
    
    fig = pcdCrossSectionElev(fig, pFile,qFile,veltexts,X,Y);
    
    h_CS2  = subplot(2,2,4);
    set(h_CS2,'Position',[0.57 0.10 0.4 0.3]);
    %
    topotexts.Title     = 'Topograhic Corss Section';
    topotexts.XLabel    = 'Distance (m)';
    topotexts.YLabel    = 'Topographic Difference (mm)';
    topotexts.Legend{1} = 'Topographic Difference (mm)';
    topotexts.Legend{2} = 'Topography Time 2';
    
    fig = pcdCrossSectionTopography(fig, time1,time2,topotexts,X,Y);
        
    texts.Title = '';
    texts.Legend{1} = 'Flow Directions';
    texts.CBTitle{1} = 'dz difference (mm)';
    flt = 0.000005;
    %
    h_rast = subplot(2,2,[1 3]);
    set(h_rast,	'Position',[0.02 0.1 0.5 0.86])
    fig = pcdDZVectors(fig,pFile,qFile,time1,time2,texts,dt,X,Y,3);
    
    c1 = text(X(1)-2,Y(1)-3,'X');
    set( c1                    , ...
        'FontSize'   , 16      , ...
        'FontWeight' , 'bold'  , ...
        'FontName'   , 'Helvetica');
    
    c2 = text(X(end)-2,Y(end)+3,'Y');
    set( c2                    , ...
        'FontSize'   , 16      , ...
        'FontWeight' , 'bold'  , ...
        'FontName'   , 'Helvetica');
    
    
    sTitle = text(100,0,super_title);
    set( sTitle                    , ...
        'FontSize'   , 16          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    a = text(-1,30,'(a)');
    set( a                    , ...
        'FontSize'   , 18          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    b = text(265,21,'(b)');
    set( b                    , ...
        'FontSize'   , 16          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    c = text(265,131,'(c)');
    set( c                    , ...
        'FontSize'   , 16          , ...
        'FontWeight' , 'bold'      , ...
        'FontName'   , 'Helvetica');
    
    cs_X = text(261,101,'X');
    set( cs_X                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    cs_Y = text(452,101,'Y');
    set( cs_Y                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    
    cs_X1 = text(261,211,'X');
    set( cs_X1                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    cs_Y1 = text(452,211,'Y');
    set( cs_Y1                      , ...
        'FontSize'   , 14          , ...
        'FontWeight' , 'bold'      , ...
        'Color'      , [.3 .3 .3]  , ...
        'FontName'   , 'Helvetica');
    
    
    save = strcat(First,'_',Second,'_Half_Hour_dz.eps');
    
    if ~isempty(save)
    
        set(fig, 'PaperPositionMode', 'auto');
        print('-depsc2','-r300',save)
        close;
        fixPSlinestyle(save,save);
    
    end
    
end
%
%
% % ind = [3:65 67:77 79:123 125 147]; % consective scans excluding the nonreadable scans
% %
% % % ind = [3, 10, 21 32 42 54 64 74 88 98 109 121 132]; %6hr
% %
% % % ind = [3, 21 42 64 88 109 121 132] %12hr
% %
% % dt = 12 % for 12 hr adjust accordingly
% %
% % for ii = 1:length(ind)-1
% %
% %     ind(ii)
% %
% %     [Y, M, D, H, MN, S] = datevec(datenum(datestr(scanID(ii).Time)) - datenum(datestr(scanID(ii+1).Time)));
% %
% %     First = scanID(ind(ii)).ID;
% %     Second = scanID(ind(ii+1)).ID;
% %
% %     dloc='/Volumes/fshahzad/src/Simulations/20121213/';
% %     refFile = [dloc 'RAW/015_01.pcd'];
% %     pFile = [dloc 'DIFF/' First '__' Second '_PLIST.pcd']
% %     qFile = [dloc 'DIFF/' First '__' Second '_QLIST.pcd']
% %
% %     texts.Title = strcat('Surface Velcities between ', scanID(ind(ii)).Time, ...
% %         ' and ',scanID(ind(ii+1)).Time,' on ',scanID(ii).Date);
% %
% %     texts.Legend{1} = 'Flow Directions';
% %     texts.CBTitle{1} = 'Velocity (mm/hr)';
% %     flt = 0.0005;
% %
% %     save = strcat('/Users/fshahzad/Desktop/211212/6hr_2/',First,'_',Second,'_6hr_2m.eps');
% %
% %     pcdFlowStreamLines(pFile,qFile,dt,texts,flt,save);
% %
% % end