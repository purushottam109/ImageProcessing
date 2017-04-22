%function correspond = correspondences( im1,corner1,im2, corners2) takes in the
%the two Grayscale images im1 ,im1 and their respective corner matrices( created
%using harris corners()) and returns the matrix correspond of the correspondoing
%corners from corners2 of im2 that have matched with the corners1 of im1.

function correspondences2( im1, im2 )
corners1 = harris_corners(im1, 7,1.5);
corners2 = harris_corners(im2, 7,1.5);
corres= zeros(size(corners1));
for n=1:200
    matchindex= matchingcorner(im1, corners1(n,:), im2, corners2);
corres(n,:)= corners2(matchindex,:);
end

im3= appendimages(im1, im2);
figure, imshow(im3); hold on;

[r, c]= size(im1);
for i=1:200
line([corners1(i,1),(corres(i,1)+ c)],[(corners1(i,2)),(corres(i,2))]);
end
end

