
% 
% axis off
% 
% clc

% figure
% a = verts(faces1,1)
% b = verts(faces1,2)
% 
% fig = figure;
% 
% spacing = 1;
% 
% for ii = 1:4
%     
%     if  a(ii) < a(ii+1)
%         newA = a(ii):a(ii+1);
%     else
%         newA = a(ii+1):a(ii);
%     end
%     
%     if  b(ii) < b(ii+1)
%         newB = b(ii):b(ii+1);
%     else
%         newB = b(ii+1):b(ii);
%     end
%         
%     if length(newA) == 1
%         
%         newA = newA * ones(1,length(newB));
%         
%     elseif length(newB) == 1
%         
%         newB = newB * ones(length(newA),1);
%         
%     elseif length(newB) > length(newA)
%         
%         newA = interp(newA,round(length(newB)/length(newA)));
%         
%     elseif length(newB) < length(newA)
% 
%         newB = interp(newB,round(length(newA)/length(newB)));
%         
%     end
%     
%     np = round(length(newA)/spacing);
% 
%     fig = esdAddBorder(fig,newA,newB,np);
%     
%     hold on
%     
% end
% 
% xlim([100 600]);
% ylim([100 500]);

% csfig = pcdMakeCrossSectionEPS (xPoints, C1, C2, meanC, err,texts);
% %
% % set(csfig, 'PaperPositionMode', 'auto');
% % print -deps2 -r300 finalPlot1.eps
% % close;
% % fixPSlinestyle('finalPlot1.eps', 'finalPlot2.eps');



% h1 = quiver(X,Y,u(:,:,ii),v(:,:,ii));
% xlabel('X');
% ylabel('Y');
% axis image
% set(h1, 'color', 'k')