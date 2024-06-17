% Load the original image and watermark
original_image = imread('blonde.tif');
watermark = imread('watermark.bmp');

% Resize watermark to match the size of the original image
watermark_resized = imresize(watermark, [size(original_image, 1), size(original_image, 2)]);

% Convert watermark to grayscale if it's not already in grayscale format
if size(watermark_resized, 3) > 1
    watermark_resized_gray = rgb2gray(watermark_resized);
else
    watermark_resized_gray = watermark_resized;
end

% Adjust the intensity of the watermark
alpha = 0.1; % Adjust transparency factor
watermark_resized_adjusted = alpha * double(watermark_resized_gray);

% Add the watermark to the original image
watermarked_image = double(original_image) + watermark_resized_adjusted;
watermarked_image = uint8(min(watermarked_image, 255)); % Ensure pixel values are within [0, 255] range

% Save watermarked image
imwrite(watermarked_image, 'watermarked_image.jpg');

% Compress the watermarked image at maximum compression
compressed_image = imresize(watermarked_image, 0.5); % Simulated compression by reducing size
imwrite(compressed_image, 'compressed_image.jpg', 'Quality', 0.1); % Set compression quality to 1 (maximum compression)

% Attempt to recover the original image and watermark from the compressed image
recovered_image = imresize(compressed_image, size(original_image));
recovered_watermark = uint8(abs(double(recovered_image) - double(original_image))); % Extract watermark by subtracting original image

% Display all images and results in a single figure
figure;

% Original Image
subplot(2, 3, 1);
imshow(original_image);
title('Original Image');

% Watermark
subplot(2, 3, 2);
imshow(watermark_resized_gray);
title('Watermark');

% Watermarked Image
subplot(2, 3, 3);
imshow(watermarked_image);
title('Watermarked Image');

% Compressed Image
subplot(2, 3, 4);
imshow(compressed_image);
title('Compressed Image');

% Recovered Image
subplot(2, 3, 5);
imshow(recovered_image);
title('Recovered Image');

% Recovered Watermark
subplot(2, 3, 6);
imshow(recovered_watermark, []);
title('Recovered Watermark');

% Adjust subplot spacing
spacing = 0.02;
set(gcf, 'Position', get(0,'Screensize'));
set(gca, 'LooseInset', [0,0,0,0]);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
set(gcf, 'Units', 'Normalized', 'Position', [0, 0, 1, 1]);
set(gcf, 'Units', 'Normalized', 'Position', [spacing, spacing, 1 - 2 * spacing, 1 - 2 * spacing]);
