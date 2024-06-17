% Load an image
original_image = imread('Lena.bmp');

% Convert original_image to double for compatibility
original_image = im2double(original_image);

% Ask the user to provide a watermark image
watermark_image = imread('watermark.bmp');

% Check if the watermark image is RGB or grayscale
if ndims(watermark_image) == 3
    % Convert RGB watermark image to grayscale
    watermark = imbinarize(rgb2gray(watermark_image));
else
    % If the watermark image is already grayscale, binarize directly
    watermark = imbinarize(watermark_image);
end

% Resize the watermark to match the size of the original image
watermark = imresize(watermark, size(original_image));

% Embed the watermark into the original image
alpha = 0.1; % Watermark strength
watermarked_image = original_image + alpha * watermark;

% Display the watermarked image
figure;
subplot(2, 3, 1);
imshow(watermarked_image, []);
title('Watermarked Image');

% Apply a filtering attack (e.g., low-pass filtering)
filtered_image = imfilter(watermarked_image, fspecial('gaussian', [5 5], 2));

% Display the filtered image
subplot(2, 3, 2);
imshow(filtered_image, []);
title('Filtered Image');

% Attempt to recover the watermark (assuming knowledge of the attack)
recovered_watermark = double(filtered_image - original_image) / alpha;

% Display the recovered watermark
subplot(2, 3, 3);
imshow(recovered_watermark, []);
title('Recovered Watermark');

% Measure similarity between original and recovered watermarks
similarity = corr2(watermark, recovered_watermark);
fprintf('Similarity between original and recovered watermark: %.2f\n', similarity);

% Apply inverse filtering to recover the original image
recovered_original_image = filtered_image - (alpha * watermark);

% Display the recovered original image
subplot(2, 3, 4);
imshow(recovered_original_image, []);
title('Recovered Original Image');

% Measure similarity between original and recovered images
image_similarity = corr2(original_image, recovered_original_image);
fprintf('Similarity between original and recovered original image: %.2f\n', image_similarity);
