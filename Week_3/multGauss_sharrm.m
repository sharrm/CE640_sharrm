function mg=multGauss(vector, matrix, rows) % function accepting three inputs
% CE640 Week 3 - Fall 2021
% Matt Sharr (sharrm)

y = 0; % Establish function 'y' as zero to be used in our For loop
x = vector; % Define 'x' as the user provided vector

disp('Computing Gaussian profiles using the input parameters...')

% source: https://www.mathworks.com/help/matlab/ref/hold.html
hold on % Add a new plot without deleting the existing

% Iterate through all rows in the input matrix. Compute Gaussian profiles
% for each row, and sum all rows as a single Gaussian profile. Plot each
% profile.
for i = 1:rows
    % Establish user readable variables for each Gaussian input parameter
    % (amplitude, standard deviation, and position)
    amp = matrix(i,1); % Amplitude portion of the input matrix
    stdev = matrix(i,2); % Standard Deviation portion of the input matrix
    pos = matrix(i,3); % Position (mean) portion of the input matrix
    
    % source: https://www.mathworks.com/help/fuzzy/gaussmf.html
    y_i = amp*gaussmf(x, [stdev pos]); % Use Matlab's gaussmf function
    
    y = y + y_i; % Add the current interation of gaussmf to the previous
     
    plot(x, y_i) % Add the current gaussmf calculation to the plot
end

plot(x, y, 'g') % Add summation of all 'y' functions to plot

%% Add title, axis labels, and legend to the plot
title('Gaussian (Normal Distribution) Profiles')
xlabel('x')
ylabel('y(x;σ,c)=e^(−(x−c)^2/2σ^2)')

% Modify the plot legend to associate each y(n) with a specific line color,
% based on the input matrix row
for i = 1:rows
    Legend{i} = ['y', num2str(i)] ;
end

Legend = [Legend 'y']; % Add the final summation y to the legend
legend(Legend) % Show the legend
    