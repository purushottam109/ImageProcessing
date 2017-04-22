%function index = matchingcorner( im1,corner1,im2, corners2) takes in the
%the two images im1 and a corner corner1 in it. Also it takes in another
%image im2 and its corner matrix. It returns the index the corner in
%corners2 which matches with corner1 the most. The function uses the
%sum-of-squared-differences as the measure to make the match.
function index = matchingcorner( im1,corner,im2, corners2)
for n=1:200
f2= corners2(n,:);
w1=window(im1,corner);
w2= window(im2,f2);
sqd=0;
for a=1:5
    for b=1:5					
	d= ((w1(a,b))-(w2(a,b)))^2; 
    sqd= sqd+ d;
    end 
end
ssd(n) = sqd;
end
[~,index]= min(ssd(:));
end
