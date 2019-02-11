%%
%Step-1: Reading trainning image and forming training data matrix D
training_images = dir('/Users/inder/Downloads/face_recognition_project/training images/*.jpg');    
D=[];
%%
%Step-2: Assigning label to the images and forming label matrix Lt
Lt=[];
total_training_images = length(training_images);  
for i = 1:total_training_images
    Caption1 = training_images(i).name;   %Assigning each image name
    Lt=[Lt;Caption1(1:3)];                %Label matrix
    Title1 = char(strcat('training images/',Caption1));%Folder which contains the images and concatenates
    Reading_image = imread(Title1);  %Reading image inside folder
    Reshaped_image=reshape(Reading_image,1,64*64); %Reshaping each image to a row vector of 4096 dimension
    D = [D;Reshaped_image];   % p by d Data matrix D 
 end
%%
%Step-3: Performing PCA on D data matrix
%Calculating mean for each image
MEAN = mean (D,2);

%Now remove each  mean from  each entry in the corresponding row
Mean_removed = [];
size_of_matrix = size(D,2);
for i = 1 : size_of_matrix
    Reshaped_image = double(D(:,i)) - MEAN;
    Mean_removed  = [Mean_removed Reshaped_image];
end

%Calculating Covariance matrix(sigma)
N = length(training_images)-1;
Sigma = (1/N)*Mean_removed*(Mean_removed');

%Finding Eigenvalues and Eigenvectors
[Eigen_vec,Eigen_val] = eigs(Sigma,length(training_images)-3);
%NOTE:For nonsymmetric and complex problems, number of eigenvalues k << d 
Phi=Mean_removed'*Eigen_vec; 

%%
%Step-4: Computing feature vectors for all training images 
Ft=[]; %Feature vectors will be stored in this matrix
for i = 1:total_training_images 
    Caption1=training_images(i).name; 
    Title1 = char(strcat('training images/',Caption1));
    Reading_image = imread(Title1);
    Reshaped_image = reshape(Reading_image,1,64*64);
    Feauture_vectors_of_training_images=double(Reshaped_image)*Phi;
    Ft=[Ft;Feauture_vectors_of_training_images];
end
%%
%Step-5: Reading test images
test_images=('/Users/inder/Downloads/face_recognition_project/test images');
filter = '*.jpg';
selected_test_File = uigetfile(fullfile(test_images , filter));
Qt = selected_test_File(1:3);
Title2 = char(strcat('test images/',selected_test_File));%Folder which contains the images
imageread2=imread(Title2);
reshaping_test_image = reshape(imageread2,1,64*64);
%%
%Computing feature vector for test images
feature_vector_of_test_image = double(reshaping_test_image)*Phi;
%%
%Computing distance
Distance = [ ];
for i=1 : size(Ft,1)
    x = (norm(feature_vector_of_test_image-Ft(i,:)))^2;
    Distance = [Distance;x];
end
%%
%Finding minimum distance
[euclide_dist_min recognized_index] = min(Distance);
recognized_img =recognized_index; 
%%
subplot(121);
imshow(imageread2);title('Test Image');
subplot(122);
imshow(reshape(D(recognized_img,:),64,64));title('Found');
%%
%Step-6: Finding Accuracy
error = 0;
test_images = dir('/Users/inder/Downloads/face_recognition_project/test images/*.jpg');
for i = 1 : length(test_images)
    
 Caption1 = test_images(i).name;
 Title2 = char(strcat('test images/',Caption1));
 image = imread(Title2);
 reshaped_img = reshape(image,1,64*64);
 rec = double(reshaped_img)*Phi; 
 
for TTI=1:total_training_images
    z(TTI) = (norm(rec-Ft(TTI,:)))^2;    
end
 
 [minimum index]=min(z);

if Lt(index,1:end)~=Title2(:,13:15)
 error=error+1;
end
end
%%
%Accuracy 
Accuracy=(1-(error/length(test_images)))*100