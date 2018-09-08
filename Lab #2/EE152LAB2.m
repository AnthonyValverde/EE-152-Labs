%%PART 1 Sampling and Resizing
%% set variables sky && fence, aliased and unaliased
sky = imread('sky.jpg');
fence = imread('fence.jpg');
sky_aliased = imresize(sky, [128 128], 'Antialiasing',false);
sky_128 = imresize(sky, [128 128]);
figure;
imshow(sky_aliased);
figure();
imshow(sky_128);
fence_aliased = imresize(fence, [128 128], 'Antialiasing',false);
fence_128 = imresize(fence, [128 128]);
figure;
imshow(fence_aliased);
figure();
imshow(fence_128);
%%repolarize and near sided sky
sky_aliased_near = imresize(sky_aliased, [512 512], 'method', 'nearest');
figure;
imshow(sky_aliased_near);
sky_near = imresize(sky_128, [512 512], 'method', 'nearest');
figure;
imshow(sky_near);
%%repolarize and near sided fence
fence_aliased_near = imresize(fence_aliased, [512 512], 'method', 'nearest');
figure;
imshow(fence_aliased_near);
fence_near = imresize(fence_128, [512 512], 'method', 'nearest');
figure;
imshow(fence_near);
%%repolarize bilinear sky
sky_aliased_bilinear = imresize(sky_aliased, [512 512], 'method', 'bilinear');
figure;
imshow(sky_aliased_bilinear);
sky_bilinear = imresize(sky_128, [512 512], 'method', 'bilinear');
figure;
imshow(sky_bilinear);
%%repolarize bilinear fence
fence_aliased_bilinear = imresize(fence_aliased, [512 512], 'method', 'bilinear');
figure;
imshow(fence_aliased_bilinear);
fence_bilinear = imresize(fence_128, [512 512], 'method', 'bilinear');
figure;
imshow(fence_bilinear);
%%repolarize bicubic sky
sky_aliased_bicubic = imresize(sky_aliased, [512 512], 'method', 'bicubic');
figure;
imshow(sky_aliased_bicubic);
sky_bicubic = imresize(sky_128, [512 512], 'method', 'bicubic');
figure;
imshow(sky_bicubic);
%%repolarize bicubic fence
fence_aliased_bicubic = imresize(fence_aliased, [512 512], 'method', 'bicubic');
figure;
imshow(fence_aliased_bicubic);
fence_bicubic = imresize(fence_128, [512 512], 'method', 'bicubic');
figure;
imshow(fence_bicubic);

%% PART 2 Quantization
%%quantization of sky
sky_128_quan =bitset(sky_128,1, 0);
figure;
imshow(sky_128_quan);
title('Quantisized_7');
for x =2:7
sky_128_quan = bitset(sky_128_quan,x, 0);
figure;
imshow(sky_128_quan);
title(strcat('Quantized_', num2str(8-x)));
end
%%quantization of fence
fence_128_quan =bitset(fence_128,1, 0);
figure;
imshow(fence_128_quan);
title('Quantisized_7');
for x =2:7
fence_128_quan = bitset(fence_128_quan,x, 0);
figure;
imshow(fence_128_quan);
title(strcat('Quantized_', num2str(8-x)));
end
%% Part 3 Registration and Detection
me_wall = rgb2gray(imread('me_wall.jpg'));
figure;
imshow(me_wall);
blank_wall = rgb2gray(imread('blank_wall.jpg'));
figure;
imshow(blank_wall);
[optimizer, metric] = imregconfig('Multimodal');
registered = imregister(me_wall, blank_wall,'Similarity', optimizer, metric);
figure;
imshowpair(registered, blank_wall)

difference = imabsdiff(registered, blank_wall);
figure;
imshow(difference);

difference_1 = im2bw(double(difference)./255, 0.4);
figure;
imshow(difference_1);