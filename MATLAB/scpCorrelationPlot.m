% clear all
clc

dloc='/Volumes/fshahzad/src/Simulations/20130128/';

ii = 88

offs = 14;

super_title = ['Goodness of fit between ', datestr(nScanID(ii-offs).FullDate,0), ...
    ' and ',datestr(nScanID(ii-offs+1).FullDate,13)];

corrFile = [dloc num2str(ii) '_01__0' num2str(ii+1) '_01_CORR.pcd']
corrFile = [dloc '088_01__089_01_CORR.pcd'];

rast = 1./(1+pcdGrid2rast(corrFile,3));

fig = figure;
imagesc(rast);
axis image
title(corrFile)
cH = colorbar('location','SouthOutside','fontsize',14);
caxis([0.98, 1])

bkcolor = get(gcf,'Color');
hold on
% fig = esdOverLayPatch(fig, faces, verts,bkcolor);
axis off

title(super_title ,'FontName', 'Helvetica','FontWeight' , 'bold' ,'FontSize', 14);

% set(cH,'Position',bar);
%
save = strcat(num2str(ii),'.eps');

if ~isempty(save)
    
    set(fig, 'PaperPositionMode', 'auto');
    print('-depsc2','-r300',save)
    close;
    fixPSlinestyle(save,save);
    
end



