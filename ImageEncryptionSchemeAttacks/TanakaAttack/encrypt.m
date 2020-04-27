% Encrypts input image and helper images with Tanaka scheme and optional
% reversal step, block size 4x4
% Replace number in key with seed for random number generator
% Replace string in helper_img imread with helper images 
% (e.g. output of helper_pics.m)
% Replace string in img imread with input image
% Outputs: imgs/ScrambleRandBlock_enc_helper[1-16].png, helper images
% encrypted; imgs/ScrambleRandBlock_enc.png, input image encrypted
% Dependencies: Files found at link below should be in the same directory
% https://www.mathworks.com/matlabcentral/fileexchange/66472-image-shuffle

key = uint32(8888);

for helper_ind = 1:16
    helper_img = imread(sprintf('imgs/helper%d.png', helper_ind));
    helper_ims = imScrambleRandBlock(key, [4, 4]);
    helper_enc = helper_ims.enc(helper_img);

    imwrite(helper_enc, sprintf('imgs/ScrambleRandBlock_enc_helper%d.png', helper_ind));
end

img = imread('imgs/horse.png');
ims = imScrambleRandBlock(key, [4, 4]);
enc = ims.enc(img);

imwrite(enc, sprintf('imgs/ScrambleRandBlock_enc.png', key ) );