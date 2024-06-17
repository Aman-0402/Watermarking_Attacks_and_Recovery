% Prompt the user to select an image file
[filename, filepath] = uigetfile({'*.bmp;*.jpg;*.png;*.tif', 'Image Files (*.bmp, *.jpg, *.png, *.tif)'}, 'Select an Image File');
if filename == 0
    % User canceled the operation
    fprintf('Operation canceled. Exiting...\n');
    return;
end

% Load the selected image
originalImage = imread(fullfile(filepath, filename));

% Display the original image
figure;
subplot(1, 3, 1);
imshow(originalImage);
title('Original Image');

% Simulate a copy-paste attack: Select a region and paste it onto another part of the image
copiedRegion = originalImage(100:300, 200:400, :);
originalImage(50:250, 400:600, :) = copiedRegion;

% Display the tampered image
subplot(1, 3, 2);
imshow(originalImage);
title('Tampered Image (Copy-Paste Attack)');

% Tamper Detection
blockSize = 8;
averageOriginal = blockproc(originalImage, [blockSize blockSize], @(block) mean(block.data(:)));
averageTampered = blockproc(originalImage, [blockSize blockSize], @(block) mean(block.data(:)));
threshold = 5;
tamperedBlocks = abs(averageOriginal - averageTampered) > threshold;
tamperDetection = any(tamperedBlocks(:));

fprintf('Tamper Detection: %s\n', string(tamperDetection));

% Tamper Localization
thresholdLocalization = 20;
tamperedLocations = abs(originalImage - imgaussfilt(originalImage, 2)) > thresholdLocalization;

% Recovery Algorithm
if tamperDetection
    % Identify tampered regions
    tamperedRegion = originalImage;
    tamperedRegion(tamperedLocations) = 0; % Set tampered regions to zero
    
    % Store recovery bits
    recoveryBits = originalImage - tamperedRegion;
    
    % Simple recovery using the recovery bits
    recoveryRegion = originalImage(50:250, 150:350, :); % Region before tampering
    originalImage(50:250, 400:600, :) = recoveryRegion + recoveryBits(50:250, 400:600, :);

    % Calculate the Mean Squared Error (MSE)
    MSE = mean((double(recoveryRegion(:)) - double(originalImage(:))).^2);

    % Calculate the maximum possible pixel value (MAX)
    MAX = double(max(originalImage(:)));

    % Calculate PSNR
    PSNR = 10 * log10((MAX^2) / MSE);

    % Display the recovered image and PSNR
    figure;
    subplot(1, 2, 1);
    imshow(originalImage);
    title('Recovered Image');

    subplot(1, 2, 2);
    imshow(recoveryRegion);
    title('Recovered Region');

    fprintf('PSNR between Recovered Image and Watermarked Image: %.2f dB\n', PSNR);
else
    fprintf('No tampering detected. No recovery needed.\n');
end
