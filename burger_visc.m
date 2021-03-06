%graphics_toolkit('qt');
%                           -------------Burgers program-------------
% This program computes numerical solutions for viscid and inviscid Burgers equation.
% It needs the functions df.m, f.m, nf.m and uinit.m .
clear all
ictype = 5;

%Selection of numerical parameters (time step, grid spacing, etc...).
xend = 2*pi;   % x-axis size.
tend = 1;   % t-axis size.
N = input('Enter the number of grid points: ');
dx = xend/N; % Grid spacing
nt = input('Enter the number of time steps: ');
visc = input('Enter viscosity: ');

x  = linspace(0,xend,N);
dt = tend/nt;

%Set up the initial solution values.
u0 = uinit(x,ictype); %Call to the function "uinit". u =u0;
figure(1);
plot(u0)
U=zeros(nt,N);

%Implementation of the numerical methods.
h = waitbar(0,'Initializing waitbar...');
U(1,:) = u0;
waitbar(1/nt,h,'Progresso')
tic;
 for i = 2 : nt,
  %omogenea (lax-wendroff)
%  unew(2:end-1) = u(2:end-1) ...
%      - 0.5*dt/dx * (f(u(3:end)) - f(u(1:end-2))) ...
%      + 0.5*(dt/dx)^2 * ...
%      ( df(0.5*(u(3:end) + u(2:end-1))) .* (f(u(3:end)) - f(u(2:end-1))) - ...
%      df(0.5*(u(2:end-1) + u(1:end-2))) .* (f(u(2:end-1)) - f(u(1:end-2))) );
%  unew(1)   = u(1);
%  unew(end) = u(end);
  
  
  %parte viscosa
%  visc=0.01;
  
  unew  = cn_visc(U(i-1,:), dt, dx, visc);
  waitbar(i/nt,h,sprintf('%d%%',floor((i/nt)*100)))
  U(i,:) = unew;
%  u = -unew+u_cn'; 
%  U(i,:) = u(:);
%U(i,:) = u_cn(:);

 end
 close(h)
TimeSpent = toc;
fprintf("Tempo impiegato : %s \n", datestr(TimeSpent/86400, 'HH:MM:SS'));
T=linspace(0,tend,nt);
%Plot of the solutions.
figure(2)
surf(x,T,U)
shading interp
xlabel('x'), ylabel('t'), zlabel ('u(x,t)');
grid on
colormap('hsv');
figure(3);
plot(U(end,:),'r','LineWidth',2)
hold on;
plot(U(1,:),'LineWidth',2);
legend('U(end)','U(1)');
the_title = sprintf("Num points: %d, num time steps: %d, viscosity: %d",N,nt,visc);
title(the_title);
hold off;
