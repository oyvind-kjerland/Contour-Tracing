function database = createDatabase( )
%CREATEDATABASE Create a database of the fourier descriptors of different shapes

database = struct;
filenames = dir('database/*.png');

for f=1:length(filenames)
    filename = filenames(f).name;
    
    fullpath = strcat('database/',filename);

    I_DB = imread(fullpath);
    I_DB = segmentImage(I_DB);
    B_DB = trace(I_DB);
    BBOX_DB = getBoundingBox(B_DB);
    B_DB = repositionBoundary(B_DB);
    FD_DB = getFD(B_DB);
    
    database(f).name = filename;
    %database(f).I = I_DB;
    %database(f).B = B_DB;
    database(f).BBOX = BBOX_DB;
    database(f).FD = FD_DB;
end

end

