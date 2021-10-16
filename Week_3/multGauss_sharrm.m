function mg=multGauss(vector, matrix, rows)
%multGauss 
%   
% x will be in the main script

% the function will be in this part here
% function needs to be general, accept a matrix, and the x vector

y = 0; % Define y as zero to begin

hold on % Add a new plot without deleting the existing

for i = 1:rows % For all of the rows in the input matrix, from 1 to our known number of rows
    amp = matrix(i,1); % Amplitude portion of the input matrix
    stdev = matrix(i,2); % Standard Deviation portion of the input matrix
    pos = matrix(i,3); % Position (mean) portion of the input matrix
    
    y_i = amp*gaussmf(vector, [stdev pos]); % Use Matlabs gaussmf function
    y = y + y_i; % Save the current interation of gaussmf and add to the previous
     
    plot(vector, y_i) % Add gaussmf calculation to plot
end

plot(vector, y, 'g') % Add summation of all 'y' calculation to plot

%% Add title, axis labels, and legend to the plot
title('Gaussian Normal Distribution Profiles')
xlabel('x')
ylabel('f(x;σ,c)=e^(−(x−c)^2/2σ^2)')

for i = 1:rows
    Legend{i} = ['y', num2str(i)] ;
end

Legend = [Legend 'y'];
legend(Legend)
    