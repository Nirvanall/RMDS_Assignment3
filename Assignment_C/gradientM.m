function G = gradientM(h, w)

i = zeros(2*(h-1)*w+2*(w-1)*h, 1);
j = zeros(2*(h-1)*w+2*(w-1)*h, 1);
v = zeros(2*(h-1)*w+2*(w-1)*h, 1);

a = 1;

for m = 1:w*h % vertical gradient
    if(mod(m,h)~=0)
        i(a) = ceil(a/2);
        j(a) = m;
        v(a) = 1;
        a = a + 1;
        i(a) = ceil(a/2);
        j(a) = m+1;
        v(a) = -1;
        a = a + 1;
    end    
end

for n = 1:(w-1)*h % horizental gradient 
    i(a) = ceil(a/2);
    j(a) = n;
    v(a) = -1;
    a = a + 1;
    i(a) = ceil(a/2);
    j(a) = n + h;
    v(a) = 1;
    a = a + 1;
end

G = sparse(i,j,v);

end