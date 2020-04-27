% Decrypts input image for SKK different keys variant using basic attack
% Replace string in enc imread with encrypted input image
% Outputs: imgs/dec.png, input image decrypted; imgs/dec_gray.png, 
% grayscale version

enc = imread('imgs/enc_shuffle.png');
size_x = size(enc, 1);
size_y = size(enc, 2);

dec = zeros(size_x, size_y, 3, 'uint8');

for i = 1:size_x
    for j = 1:size_y
        for rgb = 1:3
            val = enc(i, j, rgb);
            if val <= 127
                dec(i, j, rgb) = val;
            else
                dec(i, j, rgb) = bitxor(val, 255);
            end
        end
    end
end

imwrite(dec, 'imgs/dec.png');
imwrite(rgb2gray(dec), 'imgs/dec_gray.png');