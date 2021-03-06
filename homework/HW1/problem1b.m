clc,clear;
% Read Image Files
file_path =  './data1/';% Image Flies Path
img_path_list = dir(strcat(file_path,'*.jpg'));% Read File Names
img_num = length(img_path_list);% Get the Number of Files

if img_num > 0 
    horz=1:256;
    figure;
    for j = 1:img_num
        image_name = img_path_list(j).name;
        image =  imread(strcat(file_path,image_name));
        g = my_histeq(image);
%         subplot(1,img_num,j); 
        imshow(g);
        file_name=char(sprintf("result/problem 1b/%s",image_name));
        imwrite(g,file_name);
        h = my_imhist(g);
%         subplot(2,img_num,img_num+j); 
        f=bar(horz,h);
        file_name=char(sprintf("result/problem 1b/Histogram_%s",image_name));
        saveas(f,file_name);
    end
%     saveas(f,"result/problem 1b/Histogram_summary.jpg");
end

