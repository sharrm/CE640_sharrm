%% CE 640 - Fall 2021
% Week 6
% Matt Sharr (sharrm)

clear all
%% Input data

y = [0.073 0.44 0.81 1.19 1.56 1.93 2.3 2.67 3.04];
u = [57.12 75.78 83.77 89.58 94.16 97.99 100.81 102.13 102.62];

% Constants
k = 0.4; % von Karman constant
v = 0.01; % Viscosity of water (cm^2s^-1)

%% Log

u1 = 5.5; % Best estimated shear velocity

% Smooth log law
smooth = @(u1,u) ((u1/k)*log((y*u1)/v));
[s_beta,R,JCOVB,MSE] = nlinfit(y, u, smooth, [1]);

disp(['1. The best estimated shear velocity for the smooth wall model is: ' num2str(s_beta) ' (m/s)'])

% Plot the input data vs the computed best fit
% f1 = figure;
% figure(f1)
% hold on
% scatter(y, u)
% plot(y, smooth(s_beta,u))
% axis([0 3.5 50 110])
% hold off
% title('Turbulet Boundary Layer Flow - Smooth Wall Model')
% legend('Input Data', 'Best Fit', 'Location', 'northwest')
% xlabel('Depth (cm)')
% ylabel('Velocity (cm/s)')

%%

u2 = 6.1;
ks = 0.1;

rough = @(u2,u) ((u2/k)*log(y/ks)+u2*8.5);
[r_beta,R,JCOVB,MSE] = nlinfit(y, u, rough, [1]);

disp(['2a. The best estimated shear velocity for the rough wall model is: ' num2str(r_beta) ' (m/s)'])
disp(['2b. The best estimated roughness height for the rough wall model is: ' num2str(MSE) ' (cm)'])

f2 = figure;
figure(f2)
hold on
scatter(y, u, 'k', 'x')
plot(y, smooth(s_beta,u), 'b')
plot(y, rough(r_beta, u), 'r')
axis([0 3.5 50 110])
hold off
title('Turbulet Boundary Layer Flow')
legend('Input Data', 'Smooth Wall Fit', 'Rough Wall Fit', 'Location', 'east')
xlabel('Depth (cm)')
ylabel('Velocity (cm/s)')
