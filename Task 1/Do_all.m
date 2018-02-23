function [] = Do_all (Input_directory)
filenames = dir(fullfile(Input_directory, '*.jpg'));
num_images = length(filenames);
for i = 1:num_images
    filename = fullfile(Input_directory, filenames(i).name);
    image = imread(filename);
    %image = imresize(image,[500 500]);
    G = Enhance_segmentation(image);
    I = Crop_resize(G,image);
    Output_directory='F:\4th year\First semester\Pattern recognition\Labs\Lab3\Generated Faces 1';
    if(sum(I)> 0)
    imwrite(I,fullfile(Output_directory,['photo' num2str(i) '.jpg']));
    end
end
end
