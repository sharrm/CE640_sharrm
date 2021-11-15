%% CE 640 - Fall 2021
% Week 7
% Matt Sharr (sharrm)

clear all
%% Differential Equations

% Compute and plot trajectory for friction coefficients of 0, 0.05, 0.1,
% and 0.2, for a launch angle and speed of 180 m/s. Plot the results.

%% Initial Inputs

% Parameters
angle = 40;
drag = 0; % [0 0.05 0.1 0.2];
gravity = 9.8;

% Initial conditions
x0 = 0;
y0 = 0;
u0 = 180*cosd(angle);
v0 = 180*sind(angle);

% Create vector of initial conditions
cond = [x0 y0 u0 v0];
% Define time domain over which to solve the problem
tspan = [0,20];

%% Function

% for i=1:length(drag)
%     par = [angle drag(i) gravity]; % Vector of parameters
%     
%     [t,x] = ode45(@traj,tspan,cond,[],par);
% end

par = [angle drag gravity];
[t,x] = ode45(@traj,tspan,cond,[],par);

%% Plot

figure(1)
plot(t,x)

% https://www.mathworks.com/help/matlab/ref/subplot.html

% subplot(4,1,1)
% plot(t,x(:,1));ylabel('x');
% subplot(4,1,2)
% plot(t,x(:,2));ylabel('y');
% subplot(4,1,3)
% plot(t,x(:,3));xlabel('t');ylabel('z')
% subplot(4,1,4)
% plot(t,x(:,4));xlabel('t');ylabel('z')

