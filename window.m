% function w = window( im, pixel) takes in the image im and pixel
% coordinates of PIXEL stores the intensity values of the pixels in
% window/patch of size 11x11 pixels aroud the PIXEL with PIXEL at the
% center and returns these values in an 11x11 matrix w.

function w = window( im,PIXEL)

PIXEL= uint8(PIXEL);
 f= PIXEL(1,:);
 r= f(1,1);
 c= f(1,2);

parfor a=1:11
i=(r-6);
        for b=1:11					
        j=(c-6);
        w(a,b) = im(i+a,j+b);
        end
end

end

