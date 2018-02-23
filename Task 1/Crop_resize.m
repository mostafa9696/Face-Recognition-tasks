function [Out] = Crop_resize (Original_img)
Img_0_1=rgb2gray(Original_img);
Img_0_1=medfilt2(Img_0_1);
Img_0_1=im2bw(Img_0_1);
bounds = regionprops(Img_0_1, 'BoundingBox', 'Area' );
    [~, Index] = max([bounds.Area]);
    Final=imcrop(Original_img,[bounds(Index).BoundingBox(1),bounds(Index).BoundingBox(2),bounds(Index).BoundingBox(3),bounds(Index).BoundingBox(4)]);    
    Out = Final;
    imshow(Out);
end