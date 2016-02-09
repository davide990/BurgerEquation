%r = dt/dx*dx
function unew = cn( u, r )
N = length( u ) - 1;
w = zeros( N + 1, 1 );
A = eye( N+1 );
for ii = 2:(N+1)
    A(ii-1,ii) = 0.25 * r;
end
for ii = 1:N
    A(ii+1,ii) = -0.25 * r;
end
for ii = 2:N
    w(ii) = u(ii) - 0.25*r * (u(ii+1) - u(ii-1));
end
unew = A \ w;
unew(1) = 0.0;
unew(N+1) = 0.0;