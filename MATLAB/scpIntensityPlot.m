dloc='/Volumes/fshahzad/src/ESD_Reconstructor/DiffCorrelation/build/';
volFile = [dloc '100_01__103_01_DIFF.pcd'];

refFile = [dloc '015_01.pcd'];
nPts = 500000;

pcdIntensityPlot(refFile,nPts,0);

% save('base_int.mat','plotdata')


set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 -r300 Intensity_.eps
close;
fixPSlinestyle('Intensity_.eps', 'Intensity_.eps');