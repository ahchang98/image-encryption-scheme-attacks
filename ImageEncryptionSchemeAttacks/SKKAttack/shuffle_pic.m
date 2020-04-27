% Permutes the color components of each pixel in the input image
% Replace string in img imread with input image
% Replace number in rng with seed for random number generator
% Outputs: imgs/shuffle.png, shuffled image

img = imread('imgs/bird.png');
size_x = size(img, 1);
size_y = size(img, 2);

rng(8888);

shuffle = zeros(size_x, size_y, 3, 'uint8');

for i = 1:size_x
    for j = 1:size_y
        shuffle_num = randi(6);
        if shuffle_num == 1
            shuffle(i, j, 1) = img(i, j, 1);
            shuffle(i, j, 2) = img(i, j, 2);
            shuffle(i, j, 3) = img(i, j, 3);
        elseif shuffle_num == 2
            shuffle(i, j, 1) = img(i, j, 1);
            shuffle(i, j, 2) = img(i, j, 3);
            shuffle(i, j, 3) = img(i, j, 2);
        elseif shuffle_num == 3
            shuffle(i, j, 1) = img(i, j, 2);
            shuffle(i, j, 2) = img(i, j, 1);
            shuffle(i, j, 3) = img(i, j, 3);
        elseif shuffle_num == 4
            shuffle(i, j, 1) = img(i, j, 2);
            shuffle(i, j, 2) = img(i, j, 3);
            shuffle(i, j, 3) = img(i, j, 1);
        elseif shuffle_num == 5
            shuffle(i, j, 1) = img(i, j, 3);
            shuffle(i, j, 2) = img(i, j, 1);
            shuffle(i, j, 3) = img(i, j, 2);
        else
            shuffle(i, j, 1) = img(i, j, 3);
            shuffle(i, j, 2) = img(i, j, 2);
            shuffle(i, j, 3) = img(i, j, 1);
        end
    end
end

imwrite(shuffle, 'imgs/shuffle.png');