% Decrypts input image with Tanaka scheme, block size 4x4
% Replace string in helpers_enc imread with encrypted helper images
% (e.g. run encrypt.m on output of helper_pics.m)
% Replace string in attack_enc imread with encrypted input image
% Outputs: imgs/helper_dec.png, helper image decrypted; 
% imgs/attack_dec.png, input image decrypted

helpers_enc = zeros(16, 4, 4, 3, 'uint8');
for helper_ind = 1:16
    helpers_enc(helper_ind, 1:4, 1:4, 1:3) = imread(sprintf('imgs/ScrambleRandBlock_enc_helper%d.png', helper_ind));
end

attack_enc = imread('imgs/ScrambleRandBlock_enc.png');

block_stop = size(attack_enc, 1)/4 - 1;

for helper_ind = 1:16
    for i = 1:4
        for j = 1:4
            for rgb = 1:3
                if helpers_enc(helper_ind, i, j, rgb) > 127 && helpers_enc(helper_ind, i, j, rgb) ~= 255
                    helpers_enc(helper_ind, i, j, rgb) = 255 - helpers_enc(helper_ind, i, j, rgb);
                    for i_block = 0:block_stop
                        for j_block = 0:block_stop
                            attack_enc(4*i_block + i, 4*j_block + j, rgb) = 255 - attack_enc(4*i_block + i, 4*j_block + j, rgb);
                        end
                    end
                end
            end
        end
    end
end

attack_dec = attack_enc;
helpers_dec = helpers_enc;

for helper_ind = 1:16
    for value = 1:3
        i_match = 0;
        j_match = 0;
        rgb_match = 0;

        for i = 1:4
            for j = 1:4
                for rgb = 1:3
                    if helpers_dec(helper_ind, i, j, rgb) == value
                        i_match = i;
                        j_match = j;
                        rgb_match = rgb;
                    end
                end
            end
        end

        if i_match ~= 0
            i_spot = idivide(helper_ind - 1, uint8(4)) + 1;
            j_spot = mod(helper_ind - 1, 4) + 1;
            rgb_spot = value;

            for i_block = 0:block_stop
                for j_block = 0:block_stop
                    attack_dec(4*i_block + i_spot, 4*j_block + j_spot, rgb_spot) = attack_enc(4*i_block + i_match, 4*j_block + j_match, rgb_match);
                end
            end
        end
    end
end

imwrite(attack_dec, 'imgs/attack_dec.png');