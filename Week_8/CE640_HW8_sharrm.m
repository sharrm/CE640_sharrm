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

%% Functions

t = 0:0.5:604800; % 604800 s/week

% Create a sin wave for each signal present in the ocean
wave = wave_amp * sin((2 * pi/wave_period) * t);
infra = infra_amp * sin((2 * pi/infra_period) * t);
tides = tides_amp * sin((2 * pi/tides_period) * t);

% Combine all signals into a single wave
combined = wave + infra + tides;

% Add noise to the ocean signal
combined_noise = combined + (0.1 * (randn(size(combined)) - 0.5));

figure(2)

subplot(4,1,1)
plot(t,combined_noise)
title('raw')

subplot(4,1,2)
plot(t(1:360),wave(1:360))
title('original wave')

subplot(4,1,3)
plot(t(1:1600),infra(1:1600))
title('original infra')

subplot(4,1,4)
plot(t,tides)
title('original tides')

%% Filtering

% https://www.mathworks.com/help/signal/ref/butter.html

figure(1)
subplot(4,1,1)
plot(t, combined_noise, 'Color', [0.1 0.7 0.9])
title('Raw Data')
ylabel('meters'); xlabel('seconds')

subplot(4,1,2)
[B,A]=butter(1, [0.075 0.12]);
wave_filt=filtfilt(B,A,combined_noise);
plot(t(1:360), wave_filt(1:360), 'Color', [0.4 0.4 0.2])
title('Wave Signal')
ylabel('meters'); xlabel('seconds')

subplot(4,1,3)
[D,C]=butter(1, [0.003 0.0075]);
infra_filt=filtfilt(D,C,combined_noise);
plot(t(1:1600), infra_filt(1:1600), 'Color', [0.7 0.5 0.9])
title('Infragravity Signal')
ylabel('meters'); xlabel('seconds')

subplot(4,1,4)
Wn = 0.0005;
[F,E]=butter(1, Wn, 'low');
tides_filt=filtfilt(F,E,combined_noise);
plot(t, tides_filt, 'Color', [0.8 0.2 0.4])
title('Tide Signature')
ylabel('meters'); xlabel('seconds')

sgtitle('Ocean Signal Time Series')



