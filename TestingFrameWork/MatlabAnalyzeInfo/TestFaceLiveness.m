l = im2double(imread('pdaf_input_lens_pos_447_left.jpg'));
r = im2double(imread('pdaf_input_lens_pos_447_right.jpg'));

prewitt = fspecial('prewitt');
prewitt = prewitt';

l = imfilter(l, prewitt);
r = imfilter(r, prewitt);

d = abs(l-r);
da = d./max(max(d));

% Apply Gamma to let us see the result easier
figure, imshow(da.^(1/2.2));
