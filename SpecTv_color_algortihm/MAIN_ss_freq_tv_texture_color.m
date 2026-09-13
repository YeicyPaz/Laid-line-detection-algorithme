%%=================================================================================
%=================MAKE SURE TO RUN THIS IN A MATLAB ENVIRONMENT====================
%%=================================================================================


% Decompose textures in image with spectral TV

%%Max_time = 2; dt = 0.25;
%Max_time = 1; dt = 0.02;  % line to decompose images in small scale
Max_time = 10; dt = 0.25;  % large scale <-- I discommented this line to decompose the image in large scale

Method.Num_method = 'proj'; % currently single method
Method.dt_proj = 0.2;
Method.iter_proj = 500;  % standard accuracy <-- I discommented this line to decompose the image in large scale
%Method.iter_proj = 5000;  % very accurate

%------------------------------------------------------------------------
%====== here we add the address of the image file =======

f = imread('/MATLAB Drive/SpecTV_color/img_CROPPED/crop_1_Chain_lines/6-Cut1.JPG');      
%------------------------------------------------------------------------


% --- IMAGE RESIZING ---
% 1. Read the original image
%original_image = imread('/MATLAB Drive/SpecTV_color/img_CROPPED/11-Cut1.jpg');   

% 2. Define the resize factor (0.25 reduce the image dimensions to 25%)
%resize_factor = 0.25; 

% 3. Apply the resize function
%f = imresize(original_image, resize_factor);

% ----------------------------

f = double(f)/255;

scale = 5;
f = f*scale;
M = max(f(:));

%======== gives the output of the original image =========
figure(1); 
imshow(f/scale)
title('Original Image f')

%------------------------------------------
disp("starting spectral decomposition.. --¡Do not close the window!--");
tic; % start of the clock

[S,T,Phi,f_r] = ss_freq_tv_evolve_color(f, Max_time, dt, Method);  % evolve image

execution_time = toc; %stop the clock
fprintf("La décomposition a pris  %.2f secondes.\n", execution_time);

%----------------------------------------------------------------------------
%here the filters are applied to show only the low frequencies in the images

% filter
H = zeros(size(T));
H(1:4)=1; % all pass
%H(4:8)=0;  %  less course texture
%H(2:5)=1.5;   %  more course texture


f_H = ss_freq_tv_filter_color( Phi, H, f_r );

figure(6); plot(T,S,'b',T,H*max(S),'r');

figure(3); 
imshow(f_H/scale);
title('Filtered Image f_H')
figure(4); 
imshow(f_r/scale); title('Residual Image f_r')

% Show phi bands
%%Ind = 1:8; % basic <----I commented this one
Ind = [1:5 10 15 20 30 40]; % large scale <-- I discommented this line to descompose the image in large scale
%%RbyC = [2 4]; % basic <----I commented this one
RbyC = [2 5]; % large scale <-- I discommented this line to descompose the image in large scale

fignum =30;
Rescale = 1;
%mul = 1.7;
mul = -1;  % normalize contrast 1.
offset = 0.7;
Mask=ones(size(Phi,1),size(Phi,2),size(Phi,3)); % no mask
I = ss_freq_tv_show_color_phi( Phi,Ind, RbyC, fignum, Rescale,Mask,[mul offset]);

%=================================================================================

% ======== Here the filtered image is saved in the Matlab drive files (f_H)=======
%you should change the name of the file depending on the image you  want to obtain
%if it is the 1 image you should write image 1 to assure you the document
%corresponds to the same image name.   ↓↓↓

save('filtered_manuscript_6-Cut1', 'f_H');

%================================================================================

disp('File. mat successfully saved');