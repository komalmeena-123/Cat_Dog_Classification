cd dataset\test\original
num_images =20;

% name_st = '(';
% name_ls = ')';
name_train = 'test';
% file_type = '.jpg';


for i = 1:num_images
    filename = strcat(num2str(i),'.jpg');
    temp_img = imread(filename);
    resized_img = imresize(temp_img,[64 64]);
%     figure, imshow(resized_img);
    imwrite(resized_img,(strcat(name_train, num2str(i),'.jpg')));
    clear temp_img;
end