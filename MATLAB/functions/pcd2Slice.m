function data=pcd2Slice(pFile,qFile)

P = pcd2mesh(pFile); 
Q = pcd2mesh(qFile);

data = pcds2displacement(P, Q);

% data = inpaint_nans(data(:,:,3),5);