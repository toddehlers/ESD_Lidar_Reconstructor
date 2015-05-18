function  [faces, verts] = esdSelectPatch(rast)

figure;

[rr cr dr] = size(rast);
imagesc(rast);
axis image off
legend 

bt = 1;
X = [];
Y = [];

while bt ~= 3
    
    [nX, nY bt] = ginput(1);
    X = [X; nX];
    Y = [Y; nY];
    hold on
    
    if length(X) == 1
        plot(nX,nY,'ko')
    else
        plot(X,Y,'k-o')
    end
    
end

npts = length(X);

p_sotred = esdSortPoints([X, Y]);

X = p_sotred(:,1);
Y = p_sotred(:,2);

verts =[
    1 1; ...
    1 rr; ...
    cr rr; ...
    cr 1; ...
    X Y ...
    ];

faces = [1  2 3 4 1 5:4+npts 5 1];