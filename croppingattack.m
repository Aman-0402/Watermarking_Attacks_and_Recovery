I=double(imread('Lena.bmp'));
W1=double(imread('Barbara.bmp'));

[cA1,cH1,cV1,cD1] = dwt2(I,'haar');
params=[0.03 0.30 0.01 0.01];
  for i=1:256
           for j=1:256
            IWA(i,j) =  cA1(i,j) + params(1) * W1(i,j);
            IWH(i,j) =  cH1(i,j) + params(2) * W1(i,j);
            IWV(i,j) =  cV1(i,j) + params(3) * W1(i,j);
            IWD(i,j) =  cD1(i,j) + params(4) * W1(i,j);
           end
        end
        IW=uint8(idwt2(IWA,IWH,IWV,IWD,'haar'));

[krp,rec]=imcrop(IW,[257 257 255 255]);
M1=1;
N1=1;
krp(M1,N1)=0; 
tform = maketform('affine',[1 0 0; 0 1 0; rec(1,1)-1 rec(1,2)-1 1]); 
krp1= imtransform(krp,tform,'XData',[1 M1],'YData',[1 N1]);
IWD1=IW-krp1;

IWD1 = double(IWD1);
[cA1_IW,cH1_IW,cV1_IW,cD1_IW] = dwt2(IWD1,'haar');

for i=1:256
           for j=1:256     
            WA1(i,j) = (cA1_IW(i,j) - cA1(i,j)) / params(1);  
            WH1(i,j) = (cH1_IW(i,j) - cH1(i,j)) / params(2);
            WV1(i,j) = (cV1_IW(i,j) - cV1(i,j)) / params(3);
            WD1(i,j) = (cD1_IW(i,j) - cD1(i,j)) / params(4);
           end
        end

figure (4);
subplot(3,2,1); imshow(WA1,[]); title('WA5');
subplot(3,2,2); imshow(WH1,[]); title('WH5');
subplot(3,2,3); imshow(WV1,[]); title('WV5');
subplot(3,2,4); imshow(WD1,[]); title('WD5');