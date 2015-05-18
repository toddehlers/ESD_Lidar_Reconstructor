% clear all
load scanids;
close all
clc
%66, 78, 124

ind = [126:135]; % consective scans excluding the nonreadable scans

% ind = [3, 10, 21 32 42 54 64 74 88 98 109 121 132]; %6hr

% ind = [3, 21 42 64 88 109 121 132] %12hr


ind = [13 14]; % selected files

dt = 1.5 % for 12 hr adjust accordingly

for ii = 1:length(ind)-1
    
    ind(ii)
    
    [Y, M, D, H, MN, S] = datevec(datenum(datestr(scanID(ii).Time)) - datenum(datestr(scanID(ii+1).Time)));
    
    First = scanID(ind(ii)).ID;
    Second = scanID(ind(ii+1)).ID;
    
    dloc='/Volumes/fshahzad/src/Simulations/20121213/';
    refFile = [dloc 'RAW/015_01.pcd'];
    pFile = [dloc 'DIFF/' First '__' Second '_PLIST.pcd']
    qFile = [dloc 'DIFF/' First '__' Second '_QLIST.pcd']
    
    data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr
    flt = 0.0005;
    d = data(:,:,4);
    siz = size(d);
    d=deleteoutliers(d(:),flt,1);
    d = reshape(d,siz);
    data(:,:,4) = d*1000;

    [CX1,CY1,C1] = improfile(data(:,:,4),CX1,CY1);
    
    xPoints=cumsum(sqrt(power(diff(CX1),2)+power(diff(CY1),2)));
    %
    texts.Title = strcat('Velocity CS between ', scanID(ind(ii)).Time, ...
        ' and ',scanID(ind(ii+1)).Time,' on ',scanID(ii).Date);
    
    texts.XLabel    = 'Distance (m)';
    texts.YLabel    = 'Velocity (m/hr)';
    texts.Legend{1} = 'Velocity (m/hr)';
    
    fig = pcdVelocityCSEPS(xPoints,C1(2:end),texts);
    
    save = strcat('/Users/fshahzad/Desktop/211212/CS/',First,'_',Second,'_CS.eps');

    set(fig, 'PaperPositionMode', 'auto');
    print ('-deps2', '-r300', save)
    close;
    fixPSlinestyle(save, save);
    
    
end


