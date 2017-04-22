function [matches, scores] = siftmatch(im1, im2)

ims1 = single(rgb2gray(im1));
ims2 = single(rgb2gray(im2));

[f1, d1] = vl_sift(ims1);
[f2, d2] = vl_sift(ims2);

[matches, scores] = vl_ubcmatch(d1, d2, 4);
matches = matches';

imgsize = size(rgb2gray(im1));
[r,~]   = size(matches);

qim = im1;
figure,  imshow(qim);

hold on;

plot(f1(1,:), f1(2,:), 'ro');

im3 = appendimages(im1, im2);
figure,  imshow(im3);

hold on;


f2(1, :) = f2(1, :) + imgsize(2);

for i = 1:r
  plot([f1(1, matches(i, 1)) f2(1, matches(i, 2))], [f1(2, matches(i, 1)) f2(2, matches(i, 2))], 'r');
end
end

