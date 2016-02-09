%r = dt/dx*dx
function unew = cn_visc( u, dt, dx, visc )
r = -visc*(dt/dx*dx);
N = length( u );
w = zeros( N, 1 );
A = eye( N )*(1-r);

for ii = 1:(N-1)
    A(ii, ii+1) = r*0.5;
end
for ii = 2:N
    A(ii, ii-1) = r*0.5;
end
u(1)=0;
u(N)=0;
u(N/2)=0;
for ii = 2:N-1
    %w(ii) = u(ii) - 2*r * u(ii);
%    w(ii) = u(ii) - 0.25*r * (u(ii+1) - u(ii-1));
    w(ii) = u(ii)-(dt/4*dx)*((u(ii+1).^2)-(u(ii-1).^2)) + ...
    ((dt.^2)/(8*(dx.^2)))*((u(ii)+u(ii+1))*((u(ii+1).^2)-(u(ii).^2))-(u(ii)+u(ii-1))*((u(ii).^2)-(u(ii-1).^2))) + ...
    ((dt*visc)/(2*(dx.^2)))*(u(ii+1)-2*u(ii)+u(ii-1)); %- 2*r * u(ii);
end
unew = A \ w;
