function fig = esdOverLayPatch(fig, faces, verts,color)

figure (fig);

obdr = plot(verts(faces(1:5),1),verts(faces(1:5),2));
set(obdr,'Color',color,'LineWidth',3,'LineStyle','-');

p = patch('Faces',faces,'Vertices',verts);
set(p,'FaceColor',color,'EdgeColor',color,'MarkerEdgeColor',color, ...
    'MarkerFaceColor',color,'MarkerSize',3)
hold on

bdr = plot(verts(faces(6:end),1),verts(faces(6:end),2),'k-');
set(bdr,'Color','k','LineWidth',2,'LineStyle','-');
