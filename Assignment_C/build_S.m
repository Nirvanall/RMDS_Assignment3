function S = build_S(SU)

[r,c] = find(SU);

[sr,sc] = size(SU);
U = reshape(SU,sr*sc,1);
% n: number of all pixels in the given image
n = sr*sc;
% m: number of selected pixels

m = n - length(r);

i = zeros(m, 1); % row indices of S
j = zeros(m, 1); % column indices of S
v = zeros(m, 1); % values of S

a = 1;
for s =1:n
    if (U(s) == 1)
        i(a) = a;
        j(a) = s;
        v(a) = 1;
    else
        continue
    end
    a = a+1;
end

S = sparse(i,j,v);