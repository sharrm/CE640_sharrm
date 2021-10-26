


% https://www.mathworks.com/help/map/ref/arcgridread.html

% % [A,R] = arcgridread('or_precip_1983_01.asc');
% [A,R] = readgeoraster('or_precip_1983_01.asc');
% % mapshow(A,R,'DisplayType','surface')
% geoshow(A,R);
% 
% % https://www.mathworks.com/matlabcentral/answers/515373-how-to-load-multiple-asc-file-in-matlab-which-consists-of-numbers-and-text
% % https://www.mathworks.com/help/matlab/import_export/process-a-sequence-of-files.html
% % https://www.mathworks.com/help/matlab/ref/dir.html
% 
% % Get geo referenced 
% R = georasterref('RasterSize',size(A),'LatitudeLimits',[ymin,ymax],'LongitudeLimits',[xmin,xmax]);
% % write to tiff file 
% tiffile = 'test.tif' ;
% geotiffwrite(tiffile,A,R)
% %% Read geotiff file
% [A, R] = geotiffread(tiffile);

files = dir('*.asc');
fnames = {files.name};
numfiles = numel(fnames);

for i=1:numfiles
    [A,R] = arcgridread(fnames{i});
end

mapshow(A,R,'DisplayType','surface')
