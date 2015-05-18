figure
plot(raw(1:end-1,1),raw(1:end-1,2),'.k','MarkerSize',5)


hold on

for i = 1:1:length(QLIST)
    
arrow([QLIST(i,1); QLIST(i,2)],[QLIST(i,1); QLIST(i,2)+5],4,'EdgeColor','k','FaceColor','k')

hold on

end
axis image
axis off