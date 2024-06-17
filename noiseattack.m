% Load the original image and the watermark
original_img = imread('pirate.tif'); % Replace 'original_image.png' with your original image file path
watermark = imread('watermark.bmp'); % Replace 'watermark.png' with your watermark image file path

% Resize the watermark to match the size of the original image
watermark_resized = imresize(watermark, [size(original_img, 1), size(original_img, 2)]);

% Embed the watermark into the original image
alpha = 0.95; % Weight of the watermark
watermarked_img = uint8(alpha * double(original_img) + (1 - alpha) * double(watermark_resized));

% Add noise to the watermarked image
noisy_watermarked_img = imnoise(watermarked_img, 'salt & pepper', 0.05); % Adding salt and pepper noise, you can change the noise type and intensity as needed

% Denoise the noisy watermarked image using a median filter
denoised_watermarked_img = medfilt2(noisy_watermarked_img, [3, 3]); % Adjust the filter size as needed

% Recover the watermark from the denoised watermarked image
recovered_watermark = double(denoised_watermarked_img) - alpha * double(original_img);
recovered_watermark = uint8(recovered_watermark / (1 - alpha));

% Threshold the recovered watermark to enhance clarity
threshold = graythresh(recovered_watermark); % Automatically determine threshold
recovered_watermark = imbinarize(recovered_watermark, threshold);

% Recover the original image from the denoised watermarked image and the recovered watermark
recovered_original_img = uint8(double(denoised_watermarked_img) - double(recovered_watermark));

% Display the original image, watermark, watermarked image, noisy watermarked image,
% recovered watermark, and recovered original image
figure;
subplot(2,3,1), imshow(original_img), title('Original Image');
subplot(2,3,2), imshow(watermark), title('Watermark');
subplot(2,3,3), imshow(watermarked_img), title('Watermarked Image');
subplot(2,3,4), imshow(noisy_watermarked_img), title('Noisy Watermarked Image');
subplot(2,3,5), imshow(recovered_watermark), title('Recovered Watermark');
subplot(2,3,6), imshow(recovered_original_img), title('Recovered Original Image');

% Compute PSNR (Peak Signal-to-Noise Ratio) between the original and recovered original images
psnr_value = psnr(original_img, recovered_original_img);
fprintf('PSNR value between original and recovered original image: %f\n', psnr_value);
