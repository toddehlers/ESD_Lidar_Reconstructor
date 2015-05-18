function p_sotred = esdSortPoints(points)

len=length(points(:,1));
p(1)=sum(points(:,1))/len;
p(2)=sum(points(:,2))/len;

angle=atan2(points(:,2)-p(2),points(:,1)-p(1));

[angle_sorted,perm]=sort(angle);

p_sorted=points;
p_sotred(:,1)=points(perm,1);
p_sotred(:,2)=points(perm,2);
p_sotred(:,3)=points(perm,3);