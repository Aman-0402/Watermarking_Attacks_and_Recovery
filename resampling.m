% Prompt user to select original image
[originalImageFileName, originalImagePath] = uigetfile({'*.jpg;*.png;*.tif;*.bmp','Image Files (*.jpg,*.png,*.tif,*.bmp)';'*.*','All Files (*.*)'},'Select Original Image');
originalImage = imread(fullfile(originalImagePath, originalImageFileName));

% Prompt user to select watermark image
[watermarkImageFileName, watermarkImagePath] = uigetfile({'*.jpg;*.png;*.tif;*.bmp','Image Files (*.jpg,*.png,*.tif,*.bmp)';'*.*','All Files (*.*)'},'Select Watermark Image');
watermarkImage = imread(fullfile(watermarkImagePath, watermarkImageFileName));

% Resize watermark image to match dimensions of original image
watermarkImage = imresize(watermarkImage, [size(originalImage, 1), size(originalImage, 2)]);

% Define alpha value for watermark blending
alpha = 0.1;

% Blend watermark into the original image
watermarkedImage = alpha * double(watermarkImage) + (1 - alpha) * double(originalImage);
watermarkedImage = uint8(watermarkedImage);

% Perform resampling attack on watermarked image
newWidth = 300;  % New width
newHeight = 200; % New height
resampledImage = imresize(watermarkedImage, [newHeight, newWidth], 'bilinear');

% Recovery of watermarked image after resampling attack
recoveredImage = imresize(resampledImage, size(watermarkedImage), 'bilinear');

% Display all images in the same figure
figure;

subplot(2,3,1);
imshow(originalImage);
title('Original Image');

subplot(2,3,2);
imshow(watermarkImage);
title('Watermark Image');

subplot(2,3,3);
imshow(watermarkedImage);
title('Watermarked Image');

subplot(2,3,4);
imshow(resampledImage);
title('Resampled Attack Image');

subplot(2,3,5);
imshow(recoveredImage);
title('Recovered Watermarked Image');
