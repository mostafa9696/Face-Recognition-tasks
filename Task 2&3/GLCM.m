function g= GLCM( Image )

   [H W L]=size(Image);
  if(L==3)
 Image=rgb2gray(Image);
  end;
 Image=Image./255;
 Image=Image.*7;
 Image =round(Image);
 Image = int32(Image);
 g=zeros(8,8);
 for i=0 :7
   for j=0:7
  for h=1:H
      for w=1:W
          if(w<W)
            if(Image(h,w)==i&&Image(h,w+1)==j)
                g(i+1,j+1)=g(i+1,j+1)+1;
            end
          end
      end;
  end;
   end
 end
 
  g=g+g';
  g=g/sum(sum(g));
end

