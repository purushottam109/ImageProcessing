% Outputs:
% 	c_coord is the N x 2 matrix containing x,y position of the corners
%
% Inputs:
% 	img 		the image as a matrix
% 	width 		the width of the smoothing function. Must be an odd integer.
% 	sigma 		standard deviation of the smoothing Gaussian
%
% % HISTORY
%   2001 Philip Torr (philtorr@microsoft.com, phst@robots.ac.uk) at Microsoft
%   Created.
% 
%  Copyright © Microsoft Corp. 2002
%
%
% REF:	"A combined corner and edge detector", C.G. Harris and M.J. Stephens
%	Proc. Fourth Alvey Vision Conf., Manchester, pp 147-151, 1988.
%
% 2007: Adapated for CS 223B Assignment 2 by Vaibhav Vaish

function [c_coord] = harris_corners(img, width, sigma)


% Check number or arguments
if (nargin < 2)
    error('not enough input in  charris');
elseif (nargin ==2)
    width = 5; 		%default
    sigma = 1;
end

% check that width is odd
if rem(width,2) ~= 1
	error('The width of the smoothing function must be odd.');
end

% Convert image to type double and to grayscale if needed.
if ndims(img) > 2
	im = double(rgb2gray(img));
else
	im = double(img);
end

% compute horizontal and vertical gradients by convolving with mask
mask = [-1 0 1; -2 0 2; -1 0 1] / 3;
Ix = conv2(im, mask, 'same');
Iy = conv2(im, mask', 'same');

% compute squares and product
% C is [Ix2  Ixy;
%		Ixy  Iy2 ]
Ixy = Ix .* Iy;
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy2 = Ixy .^2;

% Generate gaussian for smoothing.
gmask = fspecial('gaussian', width, sigma);

% Note because of the way Matlab does this GIx2, GIy2 and GIxy2 will be 'width' rows and columns 
% smaller than Ix2 for a total of (2 + width) smaller than im.
GIx2 = conv2(Ix2, gmask, 'same');
GIy2 = conv2(Iy2, gmask, 'same');
GIxy = conv2(Ixy, gmask, 'same');

% computer cornerness using k = 0.04
cornerness = (GIx2 .* GIy2 - GIxy.*GIxy) - 0.04 * ((GIx2 +GIy2).^2);

% Eliminate pixels around the border, since convolution does not produce valid values there
border = max(20,(1 + width)/2);
[H, W] = size(cornerness);
minval = min(min(cornerness));
cornerness(1:border,:) = minval;
cornerness(H-border+1:H,:) = minval;
cornerness(:,1:border) = minval;
cornerness(:,W-border+1:W) = minval;

% find pixels whose cornerness is bigger than all their neighbours
cmax = imextendedmax(cornerness,0.2);
% find indices and cornerness value for the maxima
cindex = find(cmax);
cvals = cornerness(cindex);

% We wish to find only to the top 200 corners, so we sort in descending
% order of cornerness value
[top_cvals, top_inds] = sort(cvals, 'descend');
ncorners = min(length(cvals), 200);
cinds = cindex(top_inds(1:ncorners));

% convert from indices to pixel coordinates
ycoord = rem(cinds,H);		% no zeros since we've excluded borders
xcoord = ceil(cinds/H);

c_coord = [xcoord ycoord];

return
