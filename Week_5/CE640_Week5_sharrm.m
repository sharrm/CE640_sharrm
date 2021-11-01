%% CE 640 - Fall 2021
% Week 5 assignment
% Matt Sharr (sharrm)

clear all
%% Read in .asc OR precipitation files

asc_files = dir('*.asc'); % Find all ESRI .asc files in the directory
num_files = numel(asc_files); % Find the number of .asc files

%% Find size of input files

[R,H] = arcgridread(asc_files(1).name);

raster_data = zeros(size(R));

%% Read all of the .asc files identified above, and store the raster and header
% information in arrays. Plot the read files in a figure window.

for i=1:num_files
    [R,H] = arcgridread(asc_files(i).name);
    raster_data = raster_data + R;
end

% Convert from mm to m
raster_data = raster_data / 1000;

%% Plotting and plot formatting

% Display the summarized precipition data
f = figure()
m = mapshow(raster_data,H, 'DisplayType', 'Surface');
hold on

% surf(raster_data,H,[],-10)

% Customize plot
% set(gca,'xticklabel',[], 'yticklabel', [],'XTick',[], 'YTick', []);
ylabel('Latitude (N)');
xlabel('Longitude (W)');
title('Total Annual Precipitation (Oregon 1983)');
f.Position = [75 75 700 400];
cmap = colormap(turbo);
cmap = flipud(cmap);
colormap(cmap);
c = colorbar;
c.Location = 'eastoutside';
c.Label.String = 'Precipitation (m)';

% Overlay contours
%  m = mapshow(raster_data,H,'DisplayType','contour','LineColor','k','LevelStep', 0.75, 'ShowText', 'off');

% set(gca,'color','white')

