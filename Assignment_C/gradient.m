function G = gradient(h, w)

i = zeros(2*(h-1)*w+2*(w-1)*h, 1); % row indices of G
j = zeros(2*(h-1)*w+2*(w-1)*h, 1); % column indices of G
v = zeros(2*(h-1)*w+2*(w-1)*h, 1); % values of G

a = 1; % index of i, j, and v 

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

for n = 1:(w-1)*h % horizontal gradient 
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