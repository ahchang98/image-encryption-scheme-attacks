% Decrypts input image and helper image for SKK same key variant
% Replace string in helper_enc imread with encrypted helper image
% (e.g. run encrypt.m on helper.png, rename output enc_shuffle_helper.png)
% Replace string in attack_enc imread with encrypted input image
% Outputs: imgs/helper_dec.png, helper image decrypted; 
% imgs/attack_dec.png, input image decrypted

helper_enc = imread('imgs/enc_shuffle_helper.png');
attack_enc = imread('imgs/enc_shuffle.png');
size_x = size(attack_enc, 1);
size_y = size(attack_enc, 2);

for i = 1:size_x
    for j = 1:size_y
        for rgb = 1:3
            if helper_enc(i, j, rgb) > 127
                helper_enc(i, j, rgb) = bitxor(helper_enc(i, j, rgb), 255);
                attack_enc(i, j, rgb) = bitxor(attack_enc(i, j, rgb), 255);
            end
        end
        helper_tmp = helper_enc(i, j, 1:3);
        attack_tmp = attack_enc(i, j, 1:3);
        for rgb_val = 1:3
            for rgb_ind = 1:3
                if helper_tmp(rgb_ind) == rgb_val
                    helper_enc(i, j, rgb_val) = helper_tmp(rgb_ind);
                    attack_enc(i, j, rgb_val) = attack_tmp(rgb_ind);
                    break
                end
            end
        end
    end
end

imwrite(helper_enc, 'imgs/helper_dec.png');
imwrite(attack_enc, 'imgs/attack_dec.png');