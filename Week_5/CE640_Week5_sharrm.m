%% CE 640 - Fall 2021
% Week 5 assignment
% Matt Sharr (sharrm)

clear all
%% Read in .asc OR precipitation files

asc_files = dir('*.asc'); % Find all ESRI .asc files in the directory
num_files = numel(asc_files); % Find the number of .asc files

%% Find size of input files and pre-allocate array with zeros

[R,H] = arcgridread(asc_files(1).name);
raster_data = zeros(size(R));


%% Read all of the .asc files identified above, and store the raster and header
% information in arrays. Plot the read files in a figure window.

for i=1:num_files  
    [R,H] = arcgridread(asc_files(i).name);
    raster_data = raster_data + R;
    A{i} = raster_data;
end

% Convert from mm to m
raster_data = raster_data / 1000;

%% Plotting and plot formatting

% Display the summarized precipition data
f = figure(1);
m = geoshow(raster_data, H, 'displaytype', 'texturemap');
hold on

% Customize axis labels, plot colormap, plot size, and colorbar location
ylabel('Latitude (N)');
xlabel('Longitude (W)');
title('Total Annual Precipitation (Oregon 1983)');
f.Position = [50 50 700 400];
cmap = colormap(turbo);
cmap = flipud(cmap);
colormap(cmap);
cb = colorbar;
cb.Location = 'eastoutside';
cb.Label.String = 'Precipitation (m)';

% Set NaN values to transparent since texturemap assumes NaNs as lowest
% scale value
m.AlphaDataMapping = 'none';
m.FaceAlpha = 'texturemap';
alpha(m,double(~isnan(raster_data)));

% Add contours for each m of precipitation
mapshow(raster_data, H,'DisplayType','contour','LineColor','k','LevelStep', 1, 'ShowText', 'off');

% Save output figure at the same size as screen resolution
set(gcf,'PaperPositionMode','auto')
print('OR_1983_Precipitation','-dpng','-r0')

%% Create annimation

%save to file
w = VideoWriter('precip2.avi');
% w.FrameRate = 1;
open(w);

% https://www.geeksforgeeks.org/matlab-convert-video-into-slow-motion/

for j=1:num_files
    for f=1:100
        figure(2)
        hold off
        mapshow(A{j},H,'DisplayType', 'surface')
        hold on

        cf = getframe(gcf); % Get current frame
        writeVideo(w, cf);
    end
end

close(w);

