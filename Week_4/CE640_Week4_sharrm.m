%% CE 640 - Fall 2021
% Week 4 Assignment
% Matt Sharr (sharrm)

% There are several hacks in this file. The date/time manipulation with
% textscan was not the best/cleanest option, but this is able to read the
% file provided in the assignment, plot two separate graphs, and output the
% mean values for each field and day in the file

%% Read in a buoy data file from Stonewall Bank
% Part 1: Plot air temperature as a function of time
% Part 2: Plot waveheight against wind speed
% Part 3: Write a file with a single row for each day; the values should be
% averaged, and saved as an ascii txt file.

%% Open and read the .txt file

format long g % https://www.mathworks.com/help/matlab/ref/format.html

buoy_file = fopen('hw4_data.txt');
header1 = fgetl(buoy_file); % Store the first line in the header
header2 = fgetl(buoy_file); % Store the second line in the header
bdata = textscan(buoy_file,'%17c%d%f%f%f%f%f%d%f64%f%f%f%f%f'); % Use textscan to bring in values to cell array based on data type
% I had issues with bringing date/time in as doubles, so went with
% characters instead

fclose(buoy_file); % Close the file

%% Store each read date/time element individually from the textscan character string (%17c)

yr = str2num(bdata{1}(:,1:4));
mon = str2num(bdata{1}(:,6:7));
day = str2num(bdata{1}(:,9:10));
hr = str2num(bdata{1}(:,12:13));
min = str2num(bdata{1}(:,15:16));
sec = zeros(size(min)); % No seconds portion specified in our input file format

% Convert date/time elements into serial date/time for plotting below
date_time=datenum(yr,mon,day,hr,min,sec);
label_date_time=unique(datenum(yr,mon,day));

%% Compute the average values for each day and in each column, then save the output file

% This part is a bit of a hack in order to get the month and days into the
% field two columns of the output array. I take the known values in September 
% for the file, store each individual day, and remove day '31' from August.
mon = mon(2:31); 
day = unique(day);
day(31) = [];

for d = day(1):day(end) % Day range for the month of September
    i = find(day == d); % Find elements within the same day
    s = size(i);
    first = i(1); % Store the first column index for the day
    last = first + s(1) - 1; % Find the last column index for the day
    
    % Step through each column of the input Cell Array 'bdata'
    % Compute the mean for each column on each day
    for c = 2:14 
        x(d,c) = mean(bdata{c}(first:last)); 
    end
end

output = x(:,2:14); % When I compute the mean, I get an extra column of 0s 
% at the beginning. So, I'm skipping the first column of 'x'

concat = [mon day output]; % Combine the month, day, and mean data values

remove = ["YY  " "hh " "mm " "yr  " "hr " "mn "];
header1 = erase(header1, remove); % Modify the header to not include year or time
header2 = erase(header2, remove); % Modify the next header line to not include year and time units
headers = string([split(header1) split(header2)]); % Combine header string into array of strings for each column

home
outfile=fopen('hw4_daily_data_sharm.txt','w'); % Create the output file
fprintf(outfile, '%2s%3s%6s%6s%6s%6s%6s%6s%6s%8s%6s%6s%6s%6s%6s\n', headers); % Add the headers to the output file
fprintf(outfile, '%2d%3d%6.0f%6.1f%6.1f%6.1f%6.1f%6.1f%6.0f%8.1f%6.1f%6.1f%6.1f%6.1f%6.1f\n', concat'); % Add the mean data to the output file
fclose(outfile); % Close the file

disp(['Saved hw4_daily_data_sharm.txt to: ', pwd]) % Display the file name and location

%% Find the unknown wave height values (99.00) and replace them with NaN
% This will make the scale of the wave height vs wind speed plot more
% useful
wave_height = find(bdata{5} == 99.00);
bdata{5}(wave_height) = NaN;

%% Create two separate plots for visualizing input data components

f1 = figure;
f2 = figure;

% Create a plot for air temperature over time
figure(f1)
plot(date_time,bdata{10})
set(gca,'XTick',label_date_time)
datetick('x',6,'keepticks'); % https://www.mathworks.com/help/matlab/ref/datetick.html
xlabel('Month/Day');ylabel('Degrees C')
xtickangle(90) % Change the orientation of the x-axis labels
title('Stonewall Bank - Air Temperature over Time')

% Create a plot comparing wind speed and wave height
figure(f2)
hold on
yyaxis left
ylabel('Wind Speed (m/s)', 'Color', 'b')
scatter(date_time,bdata{3},4.5,'b') % Create a scatter plot of wind speed

yyaxis right % Create secondary y axis
ylabel('Wave Height (m)', 'Color', 'r')
scatter(date_time,bdata{5},4.5,'r') % Create a scatter plot of wave height

set(gca,'XTick',label_date_time)
datetick('x',6,'keepticks');
xlabel('Month/Day')
xtickangle(90) % Change the orientation of the x-axis labels
legend('Wind Speed','Wave Height','Location','best')
title('Stonewall Bank - Wind Speed vs Wave Height')
