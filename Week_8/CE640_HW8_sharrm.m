%% CE640 - Fall 2021
% HW 8
% Matt Sharr (sharrm)

clear all
%% Times series data

% Part i
wave_period = 10; % seconds
wave_amp = 0.5; % meters

% Part ii
infra_period = 200; % seconds
infra_amp = 0.25; % meters

% Part iii 
tides_period = 45000; % seconds
tides_amp = 1.5; % meters

% Part iv
noise_period = rand(); % seconds
noise_amp = 0.01; % meters

%% Functions

t = 0:0.5:250; % 604800 s/week

% Create a sin wave for each signal present in the ocean
wave = wave_amp * sin((2 * pi/wave_period) * t);
infra = infra_amp * sin((2 * pi/infra_period) * t);
tides = tides_amp * sin((2 * pi/tides_period) * t);
noise = noise_amp * sin((2 * pi/noise_period) * t);

% Combine all signals into a single wave
combined = wave + infra + tides + noise;

%% Filtering

% https://www.mathworks.com/help/signal/ref/butter.html

hold on

subplot(2,2,1)
plot(t,combined, 'k')
title('Raw Data')
ylabel('meters'); xlabel('seconds')

subplot(2,2,2)
[B,A]=butter(5, [0.02 0.08]);
wave_filt=filtfilt(B,A,wave);
plot(t,wave_filt,'r')
title('Wave Signal')
ylabel('meters'); xlabel('seconds')

subplot(2,2,3)
[B,A]=butter(5, [0.02 0.08]);
infra_filt=filtfilt(B,A,infra);
plot(t,infra_filt,'b')
title('Infragravity Signal')
ylabel('meters'); xlabel('seconds')

subplot(2,2,4)
[B,A]=butter(5, [0.02 0.08]);
noise_filt=filtfilt(B,A,noise);
plot(t,noise_filt,'g')
title('Noise')
ylabel('meters'); xlabel('seconds')

sgtitle('Ocean Signal Time Series')



