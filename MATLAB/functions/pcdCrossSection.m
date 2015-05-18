function fig = pcdCrossSection(fig, pFile,qFile,dt,texts,flt,X,Y)

data=pcd2Velocity(pFile,qFile,dt); %dt = 2hr so the results will be m/hr

d = data(:,:,4);
siz = size(d);

d=deleteoutliers(d(:),flt,1);
d = reshape(d,siz);
data(:,:,4) = d*1000;

[CX1,CY1,C1] = improfile(data(:,:,4),X,Y);

xPoints=cumsum(sqrt(power(diff(CX1),2)+power(diff(CY1),2)));
% 
texts.Title     = 'Rhone Glacier Velocity Corss Section';
texts.XLabel    = 'Distance (m)';
texts.YLabel    = 'Velocity (m/hr)';
texts.Legend{1} = 'Velocity (m/hr)';

fig = pcdVelocityCSEPS(fig,xPoints,C1(2:end),texts)