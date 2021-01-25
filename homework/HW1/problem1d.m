clc,clear;
% Read Image Files
file_path =  './data1/';% Image Flies Path
img_path_list = dir(strcat(file_path,'*.jpg'));% Read File Names
img_num = length(img_path_list);% Get the Number of Files

if img_num > 0 
    horz=1:10:256;
%     figure;
    y=[1.55 1.52 1.52 1.5 1.5];
    for j = 1:img_num
        image_name = img_path_list(j).name;
        image =  imread(strcat(file_path,image_name));
        g1 = my_gamma(image,1,y(j));
        str=char(sprintf("result/problem 1d/CT_%d.jpg",j));
        imwrite(g1,str);
    end
end

