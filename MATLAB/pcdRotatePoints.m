function [lon, lat] = pcdRotatePoints(sLat,sLon,nX,nY,rot_angle,typ)

if strcmp(typ,'Maps')
    
    [UTMX,UTMY,utmzone] = deg2utm(sLat, sLon);
    
    X = UTMX + nX;
    Y = UTMY + nY;
    
    lat = zeros(size(X));
    lon = zeros(size(X));
    
    for kk = 1:numel(X)
        
        Point = [X(kk) Y(kk) 0];
        NewPoint = rotePT([UTMX,UTMY,0],Point,rot_angle);
        
        X(kk) = NewPoint(1);
        Y(kk) = NewPoint(2);
        
        [lat(kk), lon(kk)] = utm2deg(X(kk),Y(kk),utmzone);
        
    end
    
elseif strcmp(typ,'Pixels')
    
    UTMX = 0;
    UTMY = 0;
    
    X = UTMX + nX;
    Y = UTMY + nY;
    
    lat = zeros(size(X));
    lon = zeros(size(X));
    
    for kk = 1:numel(X)
        
        Point = [X(kk) Y(kk) 0];
        NewPoint = rotePT([UTMX,UTMY,0],Point,rot_angle);
        
        lon(kk) = NewPoint(1);
        lat(kk) = NewPoint(2);
       
    end

end