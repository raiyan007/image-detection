%% 
clc
close all
a1=imread('Capture.PNG');

% imwrite(a1,'IMG_20161208_230700_HDR.png');
%% 
a2=imread('Captureclutter.PNG');
% figure,imshow(a);title('comp');
b=rgb2gray(a1);
n=rgb2gray(a2);
hold on;
points1=detectSURFFeatures(b);
points2=detectSURFFeatures(n);
[k1,l1]=extractFeatures(b,points1);
[k2,l2]= extractFeatures(n,points2);
imshow(a1);hold on;plot(l1,'showOrientation',true);
figure,imshow(a2);hold on;plot(l2,'showOrientation',true);

%% 
   index_pairs=matchFeatures(k1,k2);
   match1=l1(index_pairs(:,1));
   match2=l2(index_pairs(:,2));
 figure;showMatchedFeatures(a1,a2,match1,match2,'montage');
 
 [tform,p1,p2]=estimateGeometricTransform(match1,match2,'affine');
 showMatchedFeatures(a1,a2,p1,p2,'montage');
 
 boxpol=[1,1;size(a1,2),1;size(a1,2),size(a1,1);1,size(a1,1);1,1];
 box=transformPointsForward(tform,boxpol);
 figure,imshow(a2);
 hold on;
 line(box(:,1),box(:,2),'color','g','linewidth',5);