% Read the watermarked image
watermarked_image = imread('Lena.bmp');

% Define the size of the blur kernel
kernel_size = 500; % Adjust the kernel size as needed

% Create a Gaussian blur kernel
kernel = fspecial('gaussian', [kernel_size kernel_size], 2); % Sigma value can be adjusted

% Apply the blur filter to the watermarked image
blurred_image = imfilter(watermarked_image, kernel, 'symmetric');

% Display the original and blurred images
figure;
subplot(1,2,1);
imshow(watermarked_image);
title('Original Watermarked Image');
subplot(1,2,2);
imshow(blurred_image);
title('Blurred Watermarked Image');

% Save the blurred image
imwrite(blurred_image, 'blurred_watermarked_image.jpg');
