% Creates helper images for Tanaka scheme attack, block size 4x4
% Outputs: imgs/helper[1-16].png, helper images 1-16

helpers = zeros(16, 4, 4, 3, 'uint8');

for helper_ind = 1:16
    x = idivide(helper_ind - 1, uint8(4)) + 1;
    y = mod(helper_ind - 1, 4) + 1;
    
    for i = 1:4
        for j = 1:4
            if i == x && j == y
                helpers(helper_ind, i, j, 1) = 1;
                helpers(helper_ind, i, j, 2) = 2;
                helpers(helper_ind, i, j, 3) = 3;
            else
                helpers(helper_ind, i, j, 1) = 0;
                helpers(helper_ind, i, j, 2) = 0;
                helpers(helper_ind, i, j, 3) = 0;
            end
        end
    end
end

for helper_ind = 1:16
    imwrite(reshape(helpers(helper_ind, 1:4, 1:4, 1:3), [4, 4, 3]), sprintf('imgs/helper%d.png', helper_ind));
end