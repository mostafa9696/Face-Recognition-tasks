function glcm= GLCM( Image )

   [H W L]=size(Image);
  if(L==3)
 Image=rgb2gray(Image);
  end;
 Image=mod(Image,8);
  Image=Image+1;
 glcm=zeros(8,8);
 SpatialRelation=[0;2];
  for h=1:H
      for w=1:W
          newH=SpatialRelation(1)+h;
          newW=SpatialRelation(2)+w;
         if newH<=H&&newW<=W
         glcmH=Image(h,w); 
         glcmW=Image(newH,newW);
         glcm(glcmH,glcmW)=glcm(glcmH,glcmW)+1;
         end;
      end;
  end;
  glcm=glcm+glcm.';
  glcm=glcm/sum(sum(glcm));
end

