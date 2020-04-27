% Creates helper image for SKK same key variant attack
% Replace size_x, size_y with x and y length respectively of input image
% Outputs: imgs/helper.png, helper image

size_x = 96;
size_y = 96;
helper = zeros(size_x, size_y, 3, 'uint8');

for i = 1:size_x
    for j = 1:size_y
        helper(i, j, 1) = 1;
        helper(i, j, 2) = 2;
        helper(i, j, 3) = 3;
    end
end

imwrite(helper, 'imgs/helper.png');