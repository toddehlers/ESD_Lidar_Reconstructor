% clear all
load scanids;
close all
clc
%66, 78, 124

ind = [3:65 67:77 79:123 125 147]; % consective scans excluding the nonreadable scans

% ind = [3, 10, 21 32 42 54 64 74 88 98 109 121 132]; %6hr

% ind = [3, 21 42 64 88 109 121 132] %12hr

dt = 12 % for 12 hr adjust accordingly

for ii = 1:length(ind)-1
    
    ind(ii)
    
    [Y, M, D, H, MN, S] = datevec(datenum(datestr(scanID(ii).Time)) - datenum(datestr(scanID(ii+1).Time)));

    First = scanID(ind(ii)).ID;
    Second = scanID(ind(ii+1)).ID;
        
    dloc='/Volumes/fshahzad/src/Simulations/20121213/';
    refFile = [dloc 'RAW/015_01.pcd'];
    pFile = [dloc 'DIFF/' First '__' Second '_PLIST.pcd']
    qFile = [dloc 'DIFF/' First '__' Second '_QLIST.pcd']
    
    texts.Title = strcat('Surface Velcities between ', scanID(ind(ii)).Time, ...
        ' and ',scanID(ind(ii+1)).Time,' on ',scanID(ii).Date);
    
    texts.Legend{1} = 'Flow Directions';
    texts.CBTitle{1} = 'Velocity (mm/hr)';
    flt = 0.0005;
    
    save = strcat('/Users/fshahzad/Desktop/211212/6hr_2/',First,'_',Second,'_6hr_2m.eps');
    
    pcdFlowStreamLines(pFile,qFile,dt,texts,flt,save);
    
end


% [CX1,CY1,C1] = improfile(data(:,:,4),X,Y);
% 
% xPoints=cumsum(sqrt(power(diff(CX1),2)+power(diff(CY1),2)));
% % 
% texts.Title     = 'Rhone Glacier Velocity Corss Section';
% texts.XLabel    = 'Distance (m)';
% texts.YLabel    = 'Velocity (m/hr)';
% texts.Legend{1} = 'Velocity (m/hr)';
% 
% fig = pcdVelocityCSEPS(xPoints,C1(2:end),texts)
% 
% set(fig, 'PaperPositionMode', 'auto');
% print -deps2 -r300 VelcotyCS.eps
% % close;
% fixPSlinestyle('VelcotyCS.eps', 'VelcotyCS.eps');
