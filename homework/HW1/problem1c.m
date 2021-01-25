clc,clear;
% Read Image Files
file_path =  './data1/';% Image Flies Path
img_path_list = dir(strcat(file_path,'*.jpg'));% Read File Names
img_num = length(img_path_list);% Get the Number of Files

if img_num > 0 
    horz=1:256;
%     figure;
    num_tiles=[4 4 6 5 5];
    limits=[0.25 0.25 0.4 0.4 0.4];
    for j = 1:img_num
        image_name = img_path_list(j).name;
        image =  imread(strcat(file_path,image_name));
        g1 = my_clahe(image, [num_tiles(j) num_tiles(j)], limits(j));
        str=char(sprintf("result/problem 1c/CT_%d.jpg",j));
        imwrite(g1,str);
        str=char(sprintf("result/problem 1c/Histogram_CT_%d.jpg",j));
        h = my_imhist(g1);
        f=bar(horz,h);
        saveas(f,str);
    end
end

