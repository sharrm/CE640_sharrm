%% CE 640 - Fall 2021
% Week 6
% Matt Sharr (sharrm)

clear all
%% Input data

y = [0.073 0.44 0.81 1.19 1.56 1.93 2.3 2.67 3.04];
u = [57.12 75.78 83.77 89.58 94.16 97.99 100.81 102.13 102.62];

% Constants
k = 0.4; % von Karman constant
v = 0.01; % Kinematic viscosity of water (cm^2s^-1)

%% Smooth Wall Model

smooth_guess = [5.5]; % Initial estimated shear velocity for the smooth model

% Smooth log law
smooth = @(s_vel,y) ((s_vel/k)*log((y*s_vel)/v));
[smooth_shear_velocity,R,JCOVB,MSE] = nlinfit(y, u, smooth, smooth_guess);

% Print message to the user
disp(['a. The best estimated shear velocity for the smooth wall model is: ' num2str(smooth_shear_velocity,4) ' (cm/s)'])

%% Rough Wall Model

rough_guess = [5 0.1]; % Initial estimated shear velocity and height roughness

% Rough log law
rough = @(r_vel,y) ((r_vel(1)/k)*log(y/r_vel(2))+r_vel(1)*8.5);
[r_beta,R,JCOVB,MSE] = nlinfit(y, u, rough, rough_guess);

% Storing values in more readable variables
rough_shear_velocity = r_beta(1);
roughness_height = r_beta(2);

% Print messages to the user
disp(['b1. The best estimated shear velocity for the rough wall model is: ' num2str(rough_shear_velocity,4) ' (cm/s)'])
disp(['b2. The best estimated roughness height for the rough wall model is: ' num2str(roughness_height,2) ' (cm)'])

%% Finely tune the smooth and rough wall models with our computed parameters

% Here, x is the set of y values in the standard smooth and rough log laws
x = 0:0.05:3.1;

u_smooth = (smooth_shear_velocity/k)*log(x*smooth_shear_velocity/v); % smooth log law
u_rough = rough_shear_velocity *((1/k)*log(x/roughness_height)+8.5); % rough log law

%% Plot the input data vs the computed best fit

figure
hold on
s = scatter(y, u, 15, 'MarkerEdgeColor', [0.2 .45 .50],...
    'MarkerFaceColor', [0 .7 .7], 'LineWidth', 1.0);
plot(x, u_smooth, 'Color', [0.49 0.18 0.55], 'LineWidth', 1.0)
plot(x, u_rough, 'Color', [0.85 0.32 0.09], 'LineWidth', 1.0)
axis([0 3.5 50 110])
title('Turbulet Boundary Layer Flow', 'Color', [0 0.45 0.74])
legend('Input Data', 'Smooth Wall Fit', 'Rough Wall Fit', 'Location', 'east')
xlabel('Depth (cm)')
ylabel('Streamwise Velocity (cm/s)')
hold off

