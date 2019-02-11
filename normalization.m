clc;
clear all;
close all;

%to read all the text files from directory
feature_dir = './features/';
txtinfo = dir('./features/*.txt');

for Y = 1 : length(txtinfo)
    thisfilename_1 = txtinfo(Y).name;
    thisfilename = strcat(feature_dir,thisfilename_1);
    thisdata = load(thisfilename) ;
    F{Y} = thisdata;
end

%initializing Fbar with first images features
F_bar = F{1};

%storing pre-defined set of features
Fp_x = [13 50 34 16 48]';
Fp_y = [20 20 34 50 50]';
flag = true;

FP = [Fp_x;Fp_y];

%creating the instance
Fto = zeros(5,2);

while flag
    
    %padding the feature patrix by 1 to make it a 5x3 matrix
    F1 = [F_bar ones(5,1)];
    %finding first transformation wrt pre-defined features
    transform = findTransformation(F1,Fp_x,Fp_y);
    F_bar_dash = applyTransformation(F1,transform);
    
    %initilazing current instance of average location
    F_bar = F_bar_dash;
    F_sum = 0;
    
    %compute for all images
    for Y = 1 : length(txtinfo)
        
        %storing each image features with padding (5x3)
        Fi = [F{Y} ones(5,1)];
        
        %finding and applying transform on each image feature wrt previous
        %average transformation (Ft)
        transform = findTransformation(Fi,F_bar(:,1),F_bar(:,2));
        C1(:,Y) = transform(:,1);
        C2(:,Y) = transform(:,2);
        
        
        F_dash = applyTransformation(Fi,transform);
        F_sum = F_sum + F_dash;
        
    end
    
    Ft = F_sum/length(txtinfo);
    
    % find out the error between previou and current instance
    error = max(max(abs(Ft-Fto)));
    Fto = Ft;
    if  error < 1.2
        flag = false;
    end
end

imagePath = './original_images/';
savepath = './normalised_images/';
searchpath = './test images/';
trainpath = './training images/';

%to read all the images from directory
imageData=dir('./original_images/*.jpg');

%Let' find total number of images
imagecount = length(imageData);

for Z = 1:imagecount
    
    % read images from directory
    imageNametemp = imageData(Z).name;
    imageName = strcat(imagePath,imageNametemp);
    image = rgb2gray(imread(imageName));    
    pad = [0 0 1]';
    
    % to find tform for each image using that image's transformation data
    T = maketform('affine',[C1(:,Z) C2(:,Z) pad]);
        
    % apply the transformation on to the image
    newImage{Z} = imtransform(image,T,'XData',[1 64],'YData',[1 64]); 
    
    %write the images into directory
    savefilename = strcat(savepath,imageNametemp);
    imwrite(newImage{Z},savefilename,'jpg');
end

%move the normalized images to respective folders 
dir1 = dir('./normalised_images/*1.jpg');
count1 = length(dir1);
splitFiles(savepath,trainpath,dir1,count1);

dir2 = dir('./normalised_images/*2.jpg');
count2 = length(dir2);
splitFiles(savepath,trainpath,dir2,count2);

dir3 = dir('./normalised_images/*3.jpg');
count3 = length(dir3);
splitFiles(savepath,trainpath,dir3,count3);

dir4 = dir('./normalised_images/*4.jpg');
count4 = length(dir4);
splitFiles(savepath,searchpath,dir4,count4);

dir5 = dir('./normalised_images/*5.jpg');
count5 = length(dir5);
splitFiles(savepath,searchpath,dir5,count5);





