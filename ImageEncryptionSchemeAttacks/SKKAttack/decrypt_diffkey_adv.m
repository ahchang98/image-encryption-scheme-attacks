% Decrypts input image for SKK different keys variant using advanced attack
% Replace string in enc imread with encrypted input image
% Replace RGB vector in initial decrypted pixel with starting value
% Outputs: imgs/dec.png, input image decrypted; imgs/dec_gray.png, 
% grayscale version

enc = imread('imgs/enc_shuffle.png');
size_x = size(enc, 1);
size_y = size(enc, 2);

dec = zeros(size_x, size_y, 3, 'uint8');
dec(1, 1, 1:3) = [141, 195, 241]; % initial decrypted pixel

for j = 2:size_y
    compare = int16(dec(1, j - 1, 1:3));
    
    perm = zeros(6, 8, 3, 'int16');
    
    perm(1, 1, 1:3) = int16([enc(1, j, 1), enc(1, j, 2), enc(1, j, 3)]);
    perm(2, 1, 1:3) = int16([enc(1, j, 1), enc(1, j, 3), enc(1, j, 2)]);
    perm(3, 1, 1:3) = int16([enc(1, j, 2), enc(1, j, 1), enc(1, j, 3)]);
    perm(4, 1, 1:3) = int16([enc(1, j, 2), enc(1, j, 3), enc(1, j, 1)]);
    perm(5, 1, 1:3) = int16([enc(1, j, 3), enc(1, j, 1), enc(1, j, 2)]);
    perm(6, 1, 1:3) = int16([enc(1, j, 3), enc(1, j, 2), enc(1, j, 1)]);
    
    for row = 1:6
        for bitflip = 0:7
            bit3 = mod(bitflip, 2);
            bit2 = mod(idivide(int16(bitflip), 2), 2);
            bit1 = mod(idivide(int16(bitflip), 4), 2);
            
            if bit1 == 0
                perm(row, bitflip + 1, 1) = perm(row, 1, 1);
            else
                perm(row, bitflip + 1, 1) = bitxor(perm(row, 1, 1), 255);
            end
            
            if bit2 == 0
                perm(row, bitflip + 1, 2) = perm(row, 1, 2);
            else
                perm(row, bitflip + 1, 2) = bitxor(perm(row, 1, 2), 255);
            end
            
            if bit3 == 0
                perm(row, bitflip + 1, 3) = perm(row, 1, 3);
            else
                perm(row, bitflip + 1, 3) = bitxor(perm(row, 1, 3), 255);
            end
        end
    end
    
    diff = zeros(6, 8, 'int16');
    
    for row = 1:6
        for col = 1:8
            diff(row, col) = sum(abs(compare - perm(row, col, 1:3)));
        end
    end
    
    min_diff = min(diff, [], 'all');
    
    for row = 1:6
        for col = 1:8
            if diff(row, col) == min_diff
                dec(1, j, 1:3) = perm(row, col, 1:3);
                break
            end
        end
    end
end

for i = 2:size_x
    for j = 1:size_y
        compare = int16(dec(i - 1, j, 1:3));
    
        perm = zeros(6, 8, 3, 'int16');

        perm(1, 1, 1:3) = int16([enc(i, j, 1), enc(i, j, 2), enc(i, j, 3)]);
        perm(2, 1, 1:3) = int16([enc(i, j, 1), enc(i, j, 3), enc(i, j, 2)]);
        perm(3, 1, 1:3) = int16([enc(i, j, 2), enc(i, j, 1), enc(i, j, 3)]);
        perm(4, 1, 1:3) = int16([enc(i, j, 2), enc(i, j, 3), enc(i, j, 1)]);
        perm(5, 1, 1:3) = int16([enc(i, j, 3), enc(i, j, 1), enc(i, j, 2)]);
        perm(6, 1, 1:3) = int16([enc(i, j, 3), enc(i, j, 2), enc(i, j, 1)]);

        for row = 1:6
            for bitflip = 0:7
                bit3 = mod(bitflip, 2);
                bit2 = mod(idivide(int16(bitflip), 2), 2);
                bit1 = mod(idivide(int16(bitflip), 4), 2);

                if bit1 == 0
                    perm(row, bitflip + 1, 1) = perm(row, 1, 1);
                else
                    perm(row, bitflip + 1, 1) = bitxor(perm(row, 1, 1), 255);
                end

                if bit2 == 0
                    perm(row, bitflip + 1, 2) = perm(row, 1, 2);
                else
                    perm(row, bitflip + 1, 2) = bitxor(perm(row, 1, 2), 255);
                end

                if bit3 == 0
                    perm(row, bitflip + 1, 3) = perm(row, 1, 3);
                else
                    perm(row, bitflip + 1, 3) = bitxor(perm(row, 1, 3), 255);
                end
            end
        end

        diff = zeros(6, 8, 'int16');

        for row = 1:6
            for col = 1:8
                diff(row, col) = sum(abs(compare - perm(row, col, 1:3)));
            end
        end

        min_diff = min(diff, [], 'all');

        for row = 1:6
            for col = 1:8
                if diff(row, col) == min_diff
                    dec(i, j, 1:3) = perm(row, col, 1:3);
                    break
                end
            end
        end
    end
end

imwrite(dec, 'imgs/dec.png');
imwrite(rgb2gray(dec), 'imgs/dec_gray.png');