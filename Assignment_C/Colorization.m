image = imread('gray.png');
%image = imread('new image - j47eo.jpg');
image = imresize(image, 0.3); % make it small
figure
imshow(image);
[h,w,d] = size(image);
coords = double(reshape(image,w*h,3));
coords = coords/255;
YIQ = rgb2ntsc(coords);
Y = YIQ(:,1);
I = YIQ(:,2);
Q = YIQ(:,3);

index_nc = []; % indices of pixel does not belong to C
index_c = []; % indices of picel belongs to C
for i=1:h*w
    if(I(i)==0)
        index_nc = [index_nc; i];
    else
        index_c = [index_c; i];
    end
end
% construct L
size_L = 4*3+(h-2)*2*5+(w-2)*2*5+(h-2)*(w-2)*8; 
i = zeros(size_L,1);
j = zeros(size_L,1);
v = zeros(size_L,1);

index_l = 1;

for m = 1:h*w
    if (m==1) % pixel on the top left corner
        var_y = var([Y(m+1); Y(m+h); Y(m+h+1)]);
        W = zeros(3,1);
        W(1) = exp(-(Y(m+1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m+h)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m+h+1)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m +1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m+h;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m+h+1;
        v(index_l) = -W(3);
        index_l = index_l + 1;
    elseif (m==h) % left bottom corner
        var_y = var([Y(m-1); Y(m+h-1); Y(m+h)]);
        W = zeros(3,1);
        W(1) = exp(-(Y(m-1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m+h-1)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m+h)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m -1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m+h-1;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m+h;
        v(index_l) = -W(3);
        index_l = index_l + 1;
    elseif (m==h*(w-1)+1) % right top corner
        var_y = var([Y(m-h); Y(m-h+1); Y(m+1)]);
        W = zeros(3,1);
        W(1) = exp(-(Y(m-h)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m-h+1)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m+1)-Y(m))^2/var_y);
        w_s = sum(W);
        i(index_l) = m;
        j(index_l) = m -h;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h+1;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m+1;
        v(index_l) = -W(3);
        index_l = index_l + 1;
    elseif (m==h*w ) % right bottom corner
        var_y = var([Y(m-h-1); Y(m-h); Y(m-1)]);
        W = zeros(3,1);
        W(1) = exp(-(Y(m-h-1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m-h)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m-1)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m-h-1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-1;
        v(index_l) = -W(3);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;
    elseif ( m>1 && m < h) % pixel on left edge
        var_y = var([Y(m-1);Y(m+1);Y(m+h-1);Y(m+h);Y(m+h+1)]);
        W = zeros(5,1);
        W(1) = exp(-(Y(m-1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m+1)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m+h-1)-Y(m))^2/var_y);
        W(4) = exp(-(Y(m+h)-Y(m))^2/var_y);
        W(5) = exp(-(Y(m+h+1)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m-1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m+1;
        v(index_l) = -W(2);
        index_l = index_l + 1;        
        i(index_l) = m;
        j(index_l) = m+h-1;
        v(index_l) = -W(3);
        index_l = index_l + 1;  
        i(index_l) = m;
        j(index_l) = m+h;
        v(index_l) = -W(4);
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m+h+1;
        v(index_l) = -W(5);
        index_l = index_l + 1;        
    elseif ( m>(h*(w-1)+1) && (m<h*w)) % pixel on right edge
        var_y = var([Y(m-h-1);Y(m-h);Y(m-h+1);Y(m-1);Y(m+1)]);
        W = zeros(5,1);
        W(1) = exp(-(Y(m-h-1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m-h)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m-h+1)-Y(m))^2/var_y);
        W(4) = exp(-(Y(m-1)-Y(m))^2/var_y);
        W(5) = exp(-(Y(m+1)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m-h-1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h+1;
        v(index_l) = -W(3);
        index_l = index_l + 1;        
        i(index_l) = m;
        j(index_l) = m-1;
        v(index_l) = -W(4);
        index_l = index_l + 1;  
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m+1;
        v(index_l) = -W(5);
        index_l = index_l + 1;  
    elseif (mod(m,h)==1) % pixel on top
        var_y = var([Y(m-h);Y(m-h+1);Y(m+1);Y(m+h);Y(m+h+1)]);
        W = zeros(5,1);
        W(1) = exp(-(Y(m-h)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m-h+1)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m+1)-Y(m))^2/var_y);
        W(4) = exp(-(Y(m+h)-Y(m))^2/var_y);
        W(5) = exp(-(Y(m+h+1)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m-h;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h+1;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;        
        i(index_l) = m;
        j(index_l) = m+1;
        v(index_l) = -W(3);
        index_l = index_l + 1;  
        i(index_l) = m;
        j(index_l) = m+h;
        v(index_l) = -W(4);
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m+h+1;
        v(index_l) = -W(5);
        index_l = index_l + 1;          
    elseif (mod(m,h)==0) % on bottom
        var_y = var([Y(m-h-1);Y(m-h);Y(m-1);Y(m+h-1);Y(m+h)]);
        W = zeros(5,1);
        W(1) = exp(-(Y(m-h-1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m-h)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m-1)-Y(m))^2/var_y);
        W(4) = exp(-(Y(m+h-1)-Y(m))^2/var_y);
        W(5) = exp(-(Y(m+h)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m-h-1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-1;
        v(index_l) = -W(3);
        index_l = index_l + 1;        
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;  
        i(index_l) = m;
        j(index_l) = m+h-1;
        v(index_l) = -W(4);
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m+h;
        v(index_l) = -W(5);
        index_l = index_l + 1;  
    else % other pixel
        var_y = var([Y(m-h-1);Y(m-h);Y(m-h+1);Y(m-1);Y(m+1);Y(m+h-1);Y(m+h);Y(m+h+1)]);
        W = zeros(8,1);
        W(1) = exp(-(Y(m-h-1)-Y(m))^2/var_y);
        W(2) = exp(-(Y(m-h)-Y(m))^2/var_y);
        W(3) = exp(-(Y(m-h+1)-Y(m))^2/var_y);
        W(4) = exp(-(Y(m-1)-Y(m))^2/var_y);
        W(5) = exp(-(Y(m+1)-Y(m))^2/var_y);
        W(6) = exp(-(Y(m+h-1)-Y(m))^2/var_y);
        W(7) = exp(-(Y(m+h)-Y(m))^2/var_y);
        W(8) = exp(-(Y(m+h+1)-Y(m))^2/var_y);
        w_s = sum(W);
        W = W/w_s;
        i(index_l) = m;
        j(index_l) = m-h-1;
        v(index_l) = -W(1);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h;
        v(index_l) = -W(2);
        index_l = index_l + 1;
        i(index_l) = m;
        j(index_l) = m-h+1;
        v(index_l) = -W(3);
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m-1;
        v(index_l) = -W(4);
        index_l = index_l + 1;        
        i(index_l) = m;
        j(index_l) = m;
        v(index_l) = 1;
        index_l = index_l + 1;  
        i(index_l) = m;
        j(index_l) = m+1;
        v(index_l) = -W(5);
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m+h-1;
        v(index_l) = -W(6);
        index_l = index_l + 1;  
        i(index_l) = m;
        j(index_l) = m+h;
        v(index_l) = -W(7);
        index_l = index_l + 1; 
        i(index_l) = m;
        j(index_l) = m+h+1;
        v(index_l) = -W(8);
        index_l = index_l + 1; 
    end
end

L = sparse(i,j,v,h*w,h*w);

%Construct S
[size_c, ~] = size(index_c);
is = zeros(size_c,1);
js = zeros(size_c,1);
vs = zeros(size_c,1);
index_s = 1;
p = 1;
for q = 1:size_c
    is(index_s) = p;
    js(index_s) = index_c(q,:);
    vs(index_s) = 1;
    index_s = index_s + 1;
    p = p + 1;
end
S = sparse(is,js,vs,size_c,h*w);
%hard contraint solution 
Ic = I(index_c);
Qc = Q(index_c);
left = [L'*L,S';S,zeros(size(S,1),size(S,1))];
righti = [zeros(size(S,2),1); Ic];
rightq = [zeros(size(S,2),1); Qc];
% solve the eqution
xi = left \ righti;
xq = left \ rightq;
% slect what we need 
In = xi(1:size(S,2),:);
Qn = xq(1:size(S,2),:);
% reconstruction
YIQnc = [Y, In, Qn];
RGB = ntsc2rgb(YIQnc);

newimage =uint8(reshape(RGB,h,w,d)*255);
figure, imshow(newimage);


