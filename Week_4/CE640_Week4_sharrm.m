%% CE 640 - Fall 2021
% Week 4 Assignment
% Matt Sharr (sharrm)

%% Read in a buoy data file from Stonewall Bank
% Part 1: Plot air temperature as a function of time
% Part 2: Plot waveheight against wind speed
% Part 3: Write a file with a single row for each day; the values should be
% averaged, and saved as an ascii txt file.

%% Open the .txt file

format long g % https://www.mathworks.com/help/matlab/ref/format.html

buoy_file = fopen('hw4_data.txt'); %another option for skipping header line
bdata = textscan(buoy_file,'%17c%d%f%f%f%f%f%d%f64%f%f%f%f%f','HeaderLines',2);

fclose(buoy_file);

yr = str2num(bdata{1}(:,1:4));
mon = str2num(bdata{1}(:,6:7));
day = str2num(bdata{1}(:,9:10));
hr = str2num(bdata{1}(:,12:13));
min = str2num(bdata{1}(:,15:16));
sec = zeros(size(min));

date_time=datenum(yr,mon,day,hr,min,sec);
label_date_time=unique(datenum(yr,mon,day));

%% Average values and save output file


    
[bdata{1}(2,1:10), mean(bdata{1,3}(2:25))]

% col2 = bdata{2}(1:714);
% 
% count=1;
% 
% for i = 2:14
%     for j = 1:714
%     mean_data(i) = bdata{i}(
%     count = count + 24
% end
  
% data_cols = [bdata{2},bdata{3},bdata{4},bdata{5},bdata{6},bdata{7},bdata{8},bdata{9},bdata{10},bdata{11},bdata{12},bdata{13},bdata{14}];
% mean_cols = mean(data_cols);
% append_cols = [yr mon mean_cols]

% home
% outfile=fopen('hw4_daily_data_sharm.txt','w');
% % save hw4_daily_data_sharm.txt data_cols -ascii
% fprintf(outfile,'%6c%6c%6.0f%6.1f%6.1f%6.1f%6.1f%6.1f%6.0f%8.1f%6.1f%6.1f%6.1f%6.1f%6.1f', append_cols);
% fclose(outfile);
% disp('Saved hw4_daily_data_sharm.txt to ')

%% Plot the data

% f1 = figure;
% f2 = figure;
% 
% figure(f1)
% plot(date_time,bdata{10})
% set(gca,'XTick',label_date_time)
% datetick('x',6,'keepticks'); % https://www.mathworks.com/help/matlab/ref/datetick.html
% xlabel('Month/Day');ylabel('Tenths of degrees C')
% xtickangle(90)
% 
% figure(f2)
% hold on
% scatter(date_time,bdata{3},'r')
% scatter(date_time,bdata{5},'b')
% set(gca,'XTick',label_date_time)
% datetick('x',6,'keepticks');
% xlabel('Month/Day');ylabel('Wind Speed')
% xtickangle(90)
% yyaxis right
% ylabel('Wave Height')
% legend('Wind Speed', 'Wave Height')




