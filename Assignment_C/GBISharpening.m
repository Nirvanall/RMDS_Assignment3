%%  Gradient-based Image Sharpening

% read image data
image=imread('WechatIMG4989.png');
figure, imshow(image)
[h, w, d]=size(image);
coords = double(reshape(image,w*h,3))/255;% pixel values of input image

cs = 7; % cs, cu parameters
cu = 0.4;
[l, ~] = size(coords); % l : number of pixel

% Compute Gradient Matrix
G = gradient(h,w);

g = zeros((h-1)*w+(w-1)*h,d);
U = zeros(l,d);
for r=1:d
    % Compute gradient for input pixel values
    g(:,r) = G*coords(:,r);
    % right side of equation
    right = cs*G'*g(:,r) + cu*coords(:,r);
    eye = sparse((1:l)',(1:l)',ones(l,1));
    % left side of equation
    left = G'*G + cu*eye;
    % Solve
    U(:,r) = left\right;
end

% reshape the new image
newimage =uint8(reshape(U,h,w,d)*255);

figure, imshow(newimage)
imwrite(newimage,'wzq.png')

