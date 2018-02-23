function [ Out ] = Enhance_segmentation( Img )
I = Img;
I(:,:,1) = imadjust(Img(:,:,1)); % R component enhancement
I(:,:,2) = imadjust(Img(:,:,2)); % G component enhancement
I(:,:,3) = imadjust(Img(:,:,3)); % B component enhancement
  final_image = zeros(size(I,1), size(I,2));
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            R = I(i,j,1);
            G = I(i,j,2);
            B = I(i,j,3);
            if(R > 95 && G > 40 && B > 20)
                v = [R,G,B];
                if((max(v) - min(v)) > 15)
                    if(abs(R-G) > 15 && R > G && R > B)
                        %it is a skin
                        final_image(i,j) = 1;
                    end
                end
            end
        end
    end
  final_image = medfilt2(final_image);
 [Image, ] = bwlabel(final_image);
Measure = regionprops(Image, 'area');
Areas = [Measure.Area];
  [~ ,Index]=max(Areas(:));
facedetect = ismember(Image,Index);
mask = facedetect > 0;
Out = mask;
end 