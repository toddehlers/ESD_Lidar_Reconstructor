close all
% clear all

clc
load nscanids.mat
scanID = nScanID;

X = [133.4839  123.0645  115.3871  108.8065  102.2258];
Y = [33.6842   77.9298  122.1754  157.3450  184.0058];

ind = [56 78 102]-14;

ii = 1;

First = scanID(ind(ii)).ID;
Second = scanID(ind(ii+1)).ID;
Third = scanID(ind(ii+2)).ID;

dloc='/Volumes/fshahzad/src/Simulations/20121213/';
pFile = [dloc 'REF/' First '__' Second '_PLIST.pcd'];
qFile = [dloc 'REF/' First '__' Second '_QLIST.pcd'];

time1 = [dloc 'REF/' First '__' Second '_PLIST.pcd'];
time2 = [dloc 'REF/' Second '__' Third '_PLIST.pcd'];

fig = figure;

super_title = ['Rhone glacier surface velocities between ', datestr(nScanID(ind(ii)).FullDate,0), ...
    ' and ',datestr(nScanID(ind(ii+1)).FullDate,13)];

texts.Title = '';
texts.Legend{1} = 'Flow Directions';
texts.CBTitle{1} = 'Velocity (mm/hr)';
flt = 0.0005;
%
dt = datestr2dt(nScanID(ind(ii)).FullDate,nScanID(ind(ii+1)).FullDate);
fig_main = pcdFlowVectors(fig, pFile,qFile,dt,texts,flt,X,Y,3);
title(super_title,'FontSize', 14,'FontWeight','bold','FontName','Helvetica');

x = [70, 132, 159];
y = [120,160, 76];



for ii = 1:length(x)
    
    bboxx = [x(ii)-20 x(ii)+20];
    bboxy = [y(ii)-20 y(ii)+20];
    
    figure(fig_main)
    hold on
    l1 = line([bboxx(1) bboxx(1)],[bboxy(1) bboxy(2)]);
    l2 = line([bboxx(1) bboxx(2)],[bboxy(1) bboxy(1)]);
    l3 = line([bboxx(2) bboxx(1)],[bboxy(2) bboxy(2)]);
    l4 = line([bboxx(2) bboxx(2)],[bboxy(2) bboxy(1)]);
    
    set(l1,'Color','k','LineWidth',3,'LineStyle','-');
    set(l2,'Color','k','LineWidth',3,'LineStyle','-');
    set(l3,'Color','k','LineWidth',3,'LineStyle','-');
    set(l4,'Color','k','LineWidth',3,'LineStyle','-');
    
    texts.Title = ['Region No. ', num2str(ii)];
    text(x(ii)-5,y(ii),num2str(ii),'FontSize', 16,'FontWeight' , 'bold' , 'FontName'   , 'Helvetica');
    
    hold off
    
    subfig = pcdVectorsBbox(figure, pFile,qFile,dt,texts,flt,X,Y,0.5,bboxx,bboxy);
    save = ['region' num2str(ii) '.eps'];
    set(fig_main, 'PaperPositionMode', 'auto');
    print('-depsc2','-r300',save)
    close(subfig);
    fixPSlinestyle(save,save);

end

save = 'main_fig.eps';
set(fig_main, 'PaperPositionMode', 'auto');
print('-depsc2','-r300',save)
close(fig_main);
fixPSlinestyle(save,save);








