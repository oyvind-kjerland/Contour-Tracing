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
    IB_DB = getBoundaries(B_DB, I_DB);
    BBOX_DB = getBoundingBox(B_DB);
    B_DB = repositionBoundary(B_DB);
    
    % Fourier descriptor
    FD_DB = getFD(B_DB);
    
    % Full boundary, both outer and inner
    FB_DB = B_DB;
    
    % Inner boundaries
    
    if (isfield(IB_DB,'boundary'))
       for i=1:length(IB_DB)
           IB_FD = getFD(IB_DB(i).boundary);
           IB_DB(i).FD = IB_FD;
           FB_DB = [FB_DB, IB_DB(i).boundary];
       end
    end
    
    % PCA descriptor
    PCA_D = getPCAdescriptor(FB_DB);

    database(f).name = filename;
    %database(f).I = I_DB;
    %database(f).B = B_DB;
    database(f).BBOX = BBOX_DB;
    database(f).FD = FD_DB;
    database(f).IB = IB_DB;
    database(f).PCA_D = PCA_D;
end

end

