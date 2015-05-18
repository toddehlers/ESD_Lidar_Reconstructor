clear all
close all
load nscanids.mat
scanID = nScanID;

ind = [88 89]-14;
% k = kml('kmlmovie_Half_Hour25');
sp = 10;
scale_length = 1

for ii = 1:1:length(ind)-1
    try
        ii
        First = scanID(ind(ii)).ID;
        Second = scanID(ind(ii+1)).ID;
        
        dloc='/Volumes/fshahzad/src/Simulations/20130128/';
        pFile = [dloc '' First '__' Second '_PLIST.pcd']
        qFile = [dloc '' First '__' Second '_QLIST.pcd']
        
        dt = datestr2dt(nScanID(ind(ii)).FullDate,nScanID(ind(ii+1)).FullDate);
        data=pcd2Velocity(qFile,pFile,dt); %dt = 2hr so the results will be m/hr
        d = data(:,:,4);
        siz = size(d);
        d=deleteoutliers(d(:),0.0005,1);
        d = reshape(d,siz);
        data(:,:,4) = d*1000;
        
        P = pcd2mesh(pFile);
        
        [rr, cr, dr] = size(data);
        [X,Y] = meshgrid(1:1:cr,1:1:rr);
        
        sz = sqrt(data(:,:,1).^2 + data(:,:,2).^2); % The length of each arrow.
        
        nX   = P(1:sp:end-1,1:sp:end-1,1);
        nY   = P(1:sp:end-1,1:sp:end-1,2);
        
        nPx = data(1:sp:end-1,1:sp:end-1,1)./sz(1:sp:end-1,1:sp:end-1);
        nPy = data(1:sp:end-1,1:sp:end-1,2)./sz(1:sp:end-1,1:sp:end-1);
        
        [lat, lon] = pcdRotatePoints(46.580,8.391,nX,nY,0,'Pixels');
        
        nPx(isnan(nPx)) = 0.0001;
        nPy(isnan(nPy)) = 0.0001;
        
        %         k.quiver(lat,lon,-nPx/1000,-nPy/1000,'name',nScanID(ind(ii)).FullDate,'Color','50000000','scale',scale_length,'altitudeMode','clampToGround','timeStamp',datestr(nScanID(ind(ii)).FullDate,30));
        
        %         imagesc(d);
        %         axis image
        %         hold on
        hst = quiver(lat,lon, -nPx,-nPy,0.5,'k');
        set(hst,'Color','k','LineWidth',1,'LineStyle','-');
        axis off
        axis image
        1
        save = strcat('Arrows_',First,'_',Second,'_Half_Hour.eps')
        set(gcf, 'PaperPositionMode', 'auto')
        print('-depsc2','-r300',save)
        2
        close;
        fixPSlinestyle(save,save);
        3
    catch
        
    end
    
end

% k.run;