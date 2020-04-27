% Encrypts input image with specifications in SKK paper
% Replace string in img imread with input image
% Replace number in rng with seed for random number generator
% Outputs: imgs/enc_negpos.png, image encrypted with negative-positive
% transformation; imgs/enc_shuffle.png, image encrypted with optional
% shuffle step

img = imread('imgs/bird.png');
size_x = size(img, 1);
size_y = size(img, 2);

enc_negpos = zeros(size_x, size_y, 3, 'uint8');

rng(8888);

for i = 1:size_x
    for j = 1:size_y
        for rgb = 1:3
            negpos = rand;
            if negpos < 0.5
                enc_negpos(i, j, rgb) = img(i, j, rgb);
            else
                enc_negpos(i, j, rgb) = bitxor(img(i, j, rgb), 255);
            end
        end
    end
end

imwrite(enc_negpos, 'imgs/enc_negpos.png');

enc_shuffle = enc_negpos;

for i = 1:size_x
    for j = 1:size_y
        shuffle = randi(6);
        if shuffle == 1
            enc_shuffle(i, j, 1) = enc_negpos(i, j, 1);
            enc_shuffle(i, j, 2) = enc_negpos(i, j, 2);
            enc_shuffle(i, j, 3) = enc_negpos(i, j, 3);
        elseif shuffle == 2
            enc_shuffle(i, j, 1) = enc_negpos(i, j, 1);
            enc_shuffle(i, j, 2) = enc_negpos(i, j, 3);
            enc_shuffle(i, j, 3) = enc_negpos(i, j, 2);
        elseif shuffle == 3
            enc_shuffle(i, j, 1) = enc_negpos(i, j, 2);
            enc_shuffle(i, j, 2) = enc_negpos(i, j, 1);
            enc_shuffle(i, j, 3) = enc_negpos(i, j, 3);
        elseif shuffle == 4
            enc_shuffle(i, j, 1) = enc_negpos(i, j, 2);
            enc_shuffle(i, j, 2) = enc_negpos(i, j, 3);
            enc_shuffle(i, j, 3) = enc_negpos(i, j, 1);
        elseif shuffle == 5
            enc_shuffle(i, j, 1) = enc_negpos(i, j, 3);
            enc_shuffle(i, j, 2) = enc_negpos(i, j, 1);
            enc_shuffle(i, j, 3) = enc_negpos(i, j, 2);
        else
            enc_shuffle(i, j, 1) = enc_negpos(i, j, 3);
            enc_shuffle(i, j, 2) = enc_negpos(i, j, 2);
            enc_shuffle(i, j, 3) = enc_negpos(i, j, 1);
        end
    end
end

imwrite(enc_shuffle, 'imgs/enc_shuffle.png');