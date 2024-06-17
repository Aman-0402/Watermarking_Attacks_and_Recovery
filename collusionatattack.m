% Load the original image and watermarked copies
originalImage = imread('Lena.bmp');
watermarkedCopy1 = imread('watermark.bmp');
watermarkedCopy2 = imread('watermnark1.bmp');

% Resize images to have the same dimensions
[rows, cols, ~] = size(originalImage);
watermarkedCopy1 = imresize(watermarkedCopy1, [rows, cols]);
watermarkedCopy2 = imresize(watermarkedCopy2, [rows, cols]);

% Perform collusion attack by averaging pixel values
colludedImage = (double(watermarkedCopy1) + double(watermarkedCopy2)) / 2;
colludedImage = uint8(colludedImage);

% Watermark recovery (for demonstration, just use a portion of the image)
recoveredWatermark = colludedImage(1:100, 1:100); % Example: use a portion as watermark

% Reconstruction of the original image using the recovered watermark
reconstructedImage = colludedImage; % Example: Assume the watermark is the same as colluded image

% Display the original image, watermarked copies, and recovered images
figure;
subplot(2, 3, 1); imshow(originalImage); title('Original Image');
subplot(2, 3, 2); imshow(watermarkedCopy1); title('Watermarked Copy 1');
subplot(2, 3, 3); imshow(watermarkedCopy2); title('Watermarked Copy 2');

subplot(2, 3, 4); imshow(colludedImage); title('Colluded Image');
subplot(2, 3, 5); imshow(reconstructedImage); title('Reconstructed Image');

% Display the recovered watermark
subplot(2, 3, 6); imshow(recoveredWatermark); title('Recovered Watermark');

% Save the recovered images
imwrite(reconstructedImage, 'recovered_image.jpg');
imwrite(recoveredWatermark, 'recovered_watermark.jpg');
