clc,clear;
% Read Image Files
file_path =  './data2/';% Image Flies Path
img_path_list = dir(strcat(file_path,'*.jpg'));% Read File Names
img_num = length(img_path_list);% Get the Number of Files
if img_num > 0 
    for j = 1:img_num
        image_name = img_path_list(j).name;
        image =  imread(strcat(file_path,image_name));
        g1=my_imresize(image,[1024 1024],'nearest');
        g2=my_imresize(image,[1024 1024],'bilinear');
        g3=my_imresize(image,[1024 1024],'bicubic');
        str=char(sprintf("result/problem 2a/%s",image_name));
        imwrite(g1,str);
        str=char(sprintf("result/problem 2b/%s",image_name));
        imwrite(g2,str);
        str=char(sprintf("result/problem 2c/%s",image_name));
        imwrite(g3,str);
    end
end

