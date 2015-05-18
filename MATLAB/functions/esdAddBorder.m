function fig = esdAddBorder(fig,datax,datay,np)

datax = interp(datax,np);
datay = interp(datay,np);

wd = length(datax)/np;
bits=reshape([1:length(datax)],wd,np);

figure(fig);

hold on

h = {};

for ii = 1:2:np
    
   h{ii} = plot(datax(bits([1, end],ii)),datay(bits([1, end],ii)),'k');
    
end

set([h{:}],'Color','k','LineWidth',3,'LineStyle','-');
 
