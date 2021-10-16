% Week 3 assignment description

x = 0:0.1:20; % Vector to pass into multGauss
A = [0.1,0.5,2;0.5,1,4;1,2,6;2,3,8]; % Matrix containing amplitude, width (stdev), and location (mean) of Gaussian profiles

[rows, cols] = size(A); % Determine number the dimensions of the input matrix

if cols==3 % Check that the number of columns is 3
     multGauss_sharrm(x, A, rows) % Enter multGauss function
elseif cols~=3 % If the number of columns is not 3, inform the user and exit the script
    explanation = 'Please check input array size. The number of columns should be 3, not ';
    disp([explanation, num2str(cols), '.'])
end





