function data=pcd2Velocity(pFile,qFile,dt)


data=pcd2Slice(pFile,qFile);
data = (data.*data);

sumData = data(:,:,1) + data(:,:,2)+data(:,:,3);

sumData = inpaint_nans(sumData,5);

data(:,:,4) = sumData/dt;