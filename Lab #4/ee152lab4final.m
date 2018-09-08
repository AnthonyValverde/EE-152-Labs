%%part4.1
me = imread('Anthony.jpg');
me = im2double(rgb2gray(me));
me = imresize(me, [256 256]);
imshow(me);
figure(1);
imhist(me);
figure(2);
%%part4.2(a)
g = fspecial('gaussian',100,2.5);
s = size(g);
g = padarray(g,[(256-s(1))/2 (256-s(1))/2],0,'both');
imagesc(g);
figure(3);
imagesc(log(abs(fftshift(fft2(g)))))
figure(4);

%%part4.3(b)
gaus1 = imfilter(me,g);
k = 1;
imshow(gaus1);
figure(5);
imagesc(log(abs(fftshift(fft2(gaus1)))));
figure(6);
imshow(imresize(gaus1, [256/(2^k) 256/(2^k)]));
figure(7);
imagesc(log(abs(fftshift(fft2(imresize(gaus1, [256/(2^k) 256/(2^k)]))))));
figure(8);
gaus2 = imfilter(gaus1,g);
k = 2;
imshow(gaus2);
figure(9);
imagesc(log(abs(fftshift(fft2(gaus2)))));
figure(10);
imshow(imresize(gaus2, [256/(2^k) 256/(2^k)]));
figure(11);
imagesc(log(abs(fftshift(fft2(imresize(G2, [256/(2^k) 256/(2^k)]))))))
figure(12);
gaus3 = imfilter(gaus2,g);
k = 2;
imshow(gaus3);
figure(13);
imagesc(log(abs(fftshift(fft2(G3)))));
figure(14);
imshow(imresize(gaus3, [256/(2^k) 256/(2^k)]));
figure(15);
imagesc(log(abs(fftshift(fft2(imresize(G3, [256/(2^k) 256/(2^k)]))))));
figure(16);
%% Part 4.2(c)
lap1 = imsubtract(gaus1,me);
imshow(lap1);
figure(17);
imagesc(log(abs(fftshift(fft2(lap1)))));
figure(18);
imshow(imresize(lap1, [128 128]));
figure(18);
imagesc(log(abs(fftshift(fft2(imresize(lap1, [128 128]))))))
figure(19);
lap2 = imsubtract(gaus2,gaus1);
imshow(lap2);
figure(20);
imagesc(log(abs(fftshift(fft2(lap2)))))
figure(21);
imshow(imresize(lap2, [64 64]));
figure(22);
imagesc(log(abs(fftshift(fft2(imresize(lap2, [64 64]))))))
figure(23);
lap3 = imsubtract(gaus3,gaus2);
imshow(lap3);
figure(24);
imagesc(log(abs(fftshift(fft2(lap3)))));
figure(25);
imshow(imresize(lap3, [32 32]));
figure(26);
imagesc(log(abs(fftshift(fft2(imresize(lap3, [32 32]))))))
%%4.3(a)
C = zeros(256,256,3);
for i = 1:3
if i == 1
[CA1, CH1, CV1, CD1] = dwt2(me, 'haar', 'mode', 'per');
C_1 = [CA1 CV1; CH1 CD1];
elseif i == 2
[CA2, CH2, CV2, CD2] = dwt2(CA1, 'haar', 'mode', 'per');
C_2 = [CA2 CV2; CH2 CD2];
C_1 = [C_2 CV1; CH1 CD1];
elseif i ==3
[CA3, CH3, CV3, CD3] = dwt2(CA2, 'haar', 'mode', 'per');
C_3 = [CA3 CV3; CH3 CD3];
C_2 = [C_3 CV2; CH2 CD2];
C_1 = [C_2 CV1; CH1 CD1];
end
 C(:,:,i) = C_1;
imagesc(C(:,:,i));

figure((i+26));
end
%%part4.3(b)
CA_2 = idwt2(CA3, CH3, CV3, CD3, 'haar', 'mode', 'per');
CA_1 = idwt2(CA_2, CH2, CV2, CD2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, CH1, CV1, CD1, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(30);

%%part4.3(c)
z = zeros(32,32);
z2 = zeros(64,64);
z3 = zeros(128,128);
%%
% CA3
CA_2 = idwt2(CA3, z, z, z, 'haar', 'mode', 'per');
CA_1 = idwt2(CA_2, z2, z2, z2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(31);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(32);
%%
% CH3
CA_2 = idwt2(z, CH3, z, z, 'haar', 'mode', 'per');
CA_1 = idwt2(CA_2, z2, z2, z2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(33);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(34);
%%
% CV3
CA_2 = idwt2(z, z, CV3, z, 'haar', 'mode', 'per');
CA_1 = idwt2(CA_2, z2, z2, z2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(35);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(36);
%%
% CD3
CA_2 = idwt2(z, z, z, CD3, 'haar', 'mode', 'per');
CA_1 = idwt2(CA_2, z2, z2, z2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(37);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(38);
%%
% CH2
CA_1 = idwt2(z2, CH2, z2, z2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(39);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(40);
%%
% CV2
CA_1 = idwt2(z2, z2, CV2, z2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(41);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(42);
%%
% CD2
CA_1 = idwt2(z2, z2, z2, CD2, 'haar', 'mode', 'per');
CA_0 = idwt2(CA_1, z3, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(43);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(44);
%%
% CH1
CA_0 = idwt2(z3, CH1, z3, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(45);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(46);
%%
% CV1
CA_0 = idwt2(z3, z3, CV1, z3, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(47);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(48);
%%
% CD1
CA_0 = idwt2(z3, z3, z3, CD1, 'haar', 'mode', 'per');
imagesc(CA_0);
figure(49);
imagesc(log(abs(fftshift(fft2(CA_0)))));
figure(50);
%%bonus
anthony = imread('anthonyface.jpg');
imshow(anthony);
anthony = imcrop(anthony, [554 90 1500 2400]);
anthony = imresize(anthony, [256 256]); 
imshow(anthony);
figure();
jacky = imread('jackyface.jpg');
imshow(jacky);
jacky = imcrop(jacky, [454 90 1500 2400]);
jacky = imresize(jacky, [256 256]); 
imshow(jacky);
figure();
morph = imfuse(anthony,jacky)
imshow(morph);
gaus11 = imfilter(morph,g);
k = 1;
imshow(gaus11);
figure(51);
imagesc(log(abs(fftshift(fft2(gaus11)))));
figure(52);
imshow(imresize(gaus11, [256/(2^k) 256/(2^k)]));
figure(53);
imagesc(log(abs(fftshift(fft2(imresize(gaus11, [256/(2^k) 256/(2^k)]))))));
figure(54);
gaus22 = imfilter(gaus11,g);
k = 2;
imshow(gaus22);
figure(55);
imagesc(log(abs(fftshift(fft2(gaus22)))));
figure(56);
imshow(imresize(gaus22, [256/(2^k) 256/(2^k)]));
figure(57);
imagesc(log(abs(fftshift(fft2(imresize(gaus2, [256/(2^k) 256/(2^k)]))))))
figure(58);
gaus33 = imfilter(gaus22,g);
k = 2;
imshow(gaus33);
figure(59);

