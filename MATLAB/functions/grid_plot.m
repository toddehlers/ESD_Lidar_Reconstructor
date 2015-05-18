figure
plot(raw(1:end-1,1),raw(1:end-1,2),'.k','MarkerSize',5);
hold on
% plot(raw(1:end-1,1),raw(1:end-1,2)+5,'.','MarkerSize',5);

for i = 1:1:length(PLIST)

    plot([PLIST(i,1); PLIST(i,1)],[PLIST(i,2); PLIST(i,2)+5],'-r','lineWidth',1);
    plot([PLIST(i,1); PLIST(i,1)+5],[PLIST(i,2); PLIST(i,2)],'-r','lineWidth',1);
    plot(PLIST(i,1),PLIST(i,2),'.r','MarkerSize',20);


    % arrow([QLIST(i,1); QLIST(i,2)],[QLIST(i,1); QLIST(i,2)+3],4,'EdgeColor','k','FaceColor','k')
end

axis image
axis off