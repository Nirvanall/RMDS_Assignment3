function g = coordinate(foreground, g)
[fr,fc] = size(foreground(:,:,1));
% get the location of nonzero elements in source image(the region of interest)
[r,c] = find(foreground(:,:,1));
rmin = min(r);
rmax = max(r);
cmin = min(c);
cmax = max(c);
width = cmax - cmin;
height = rmax - rmin;
% initialize the corresponding coordinates of boundary gradient in gradient vector "g~"
left = [];      %left gradient of the image left boundary
right = [];     % right gradient of the image right boundary
top = [];       % top gradient of the image top boundary
bottom = [];    % bottom gradient of the image bottom boundary
% find the corresponding coordinates of boundary gradient in gradient vector "g~"
for i = rmin:1:rmax
    left(i-rmin+1) = (fr-1)*fc + (cmin-2)*fr + i;
    right(i-rmin+1) = (fr-1)*fc + (cmax-1)*fr + i;
end

for j = cmin:1:cmax
    top(j-cmin+1) = (j-1)*(fr-1) + (rmin-1);
    bottom(j-cmin+1) = (j-1)*(fr-1) + rmax;
end
    coor = [top,bottom,left,right];
    g(coor,:) = zeros(size(length(coor),3));
end
