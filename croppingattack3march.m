% Clear the workspace and close all figures
clear all;
close all;

% Ask the user to input the filenames for the original image and the watermark image
original_image_filename = input('Enter the filename of the original image: ', 's');
watermark_image_filename = input('Enter the filename of the watermark image: ', 's');

% Load the original image and the watermark image
original_image = imread(original_image_filename);
watermark_image = imread(watermark_image_filename);

% Display the original image and the watermark image
figure;
subplot(1, 2, 1);
imshow(original_image);
title('Original Image');
subplot(1, 2, 2);
imshow(watermark_image);
title('Watermark Image');

% Embed the watermark into the original image using a simple overlay technique
watermarked_image = imfuse(original_image, watermark_image, 'blend', 'Scaling', 'joint');

% Display the watermarked image
figure;
imshow(watermarked_image);
title('Watermarked Image');

% Perform a cropping attack on the watermarked image
figure;
imshow(watermarked_image);
title('Watermarked Image under Cropping Attack');

% Allow user to select a region for cropping
h = drawrectangle;
wait(h); % Wait for user to finish drawing rectangle
position = h.Position;
cropped_image = imcrop(watermarked_image, position);

% Display the cropped image
figure;
subplot(1, 2, 1);
imshow(cropped_image);
title('Cropped Image');

% Attempt to recover the watermark from the cropped image (simple method: subtracting original image)
recovered_watermark = imsubtract(cropped_image, original_image);

% Display the recovered watermark
subplot(1, 2, 2);
imshow(recovered_watermark);
title('Recovered Watermark');
