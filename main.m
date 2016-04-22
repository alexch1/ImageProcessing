clc;
clear;

%% Scan Images

logpath = fopen('results_log.txt','w');
fprintf(logpath,'LOG\n');
disp('DEMO');
path_intr = [pwd,'/test_images/intrinsic_images/']; 
path_rmrf = [pwd,'/test_images/reflection_removal/'];
list_intr = dir([path_intr,'*.png']);
list_rmrf = dir([path_rmrf,'*.jpg']);
num_intr = length(list_intr);
num_rmrf = length(list_rmrf);

%% Intrinsic Image Decomposition
for i=1:num_intr
    lambda = 2;  % Can be tuned
    fprintf(logpath,'\nProcessing intrinsic_images-%d...\n',i);
    path = [path_intr,list_intr(i).name]; 
    I = im2double(imread(path));
    [R S time] = intrinsic_images(I,lambda);
    fprintf(logpath,'Time consumption: %.4fs\n',time);
    F = figure(1);
    STR = ['Intr_Img_Dec_ex',int2str(i)];
    disp(['DONE!......',STR]);
    set(F,'name',STR,'Numbertitle','off');
    subplot 131, imshow(I), title('input');
    subplot 132, imshow(R); title('reflection');
    subplot 133, imshow(S); title('shading');
    cd results_images
    saveas(1,[STR,'_~',num2str(floor(time*1000)),'ms'],'png')
    cd ..
end

%% Reflection Removal 
for i=1:num_rmrf
    lambda = 10;  % Can be tuned
    fprintf(logpath,'\nProcessing reflection_removal-%d...\n',i); 
    path = [path_rmrf,list_rmrf(i).name]; 
    I = im2double(imread(path));
    [LB LR time] = reflection_removal(I,lambda);
    fprintf(logpath,'Time consumption: %.4fs\n',time);
    F = figure(1);
    STR = ['Ref_Rem_ex',int2str(i)];
    disp(['DONE!......',STR]);
    set(F,'name',STR,'Numbertitle','off');
    subplot 131, imshow(I) , title('input');
    subplot 132, imshow(LB*1.5), title('background'); 
    subplot 133, imshow(LR*1.5), title('reflection');
    cd results_images
    saveas(1,[STR,'_~',num2str(floor(time*1000)),'ms'],'png')
    cd ..
end

fclose(logpath);
disp('ALL DONE!');
disp('Pls open results_images & results_log to check the results!')