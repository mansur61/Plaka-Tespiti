

resim = imread('plaka resmi adý'.'format'); //plaka.jpeg/png/jpg
resim = imresize(resim, [480 NaN]); % resmi istenilen býyuta ayarlýyoruz
resimgray = rgb2gray(resim);
resimbin = imbinarize(resimgray);
resim = edge(resimgray, 'sobel');

resim = imdilate(resim, strel('diamond', 2));% imdilate ile strel ile yapýlan morfolojik iþlemlerin
%açma iþlemini gerçekleþtirdik. Kapama iþlemi ise imeorde ile
%yapýlmaktadýr.

resim = imfill(resim, 'holes');% morfolojik iþlemelerden gelen istenmeyen boþluklarýn doldurulmasý 
%iþlemlerinþ imfill ile yapýyoruz. Yaparkende diyoruz ki boþluklarý holes
%adlý özelliði ile doldur veya düzelt.(Boþluktan kasýt gürültü)

resim = imerode(resim, strel('diamond', 10)); %Morfolojik iþlmelerde kapama iþlemi yapýldý.


Iprops=regionprops(resim,'BoundingBox','Area', 'Image'); % Burada kullanýlan regionprops özelliði ile de
%görüntüde almak istediðimiz nesneleri koparýp ayrý figüre olarak
%göstermeye çalýþtýk.
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

% Yukarýdaki adýmýn% 'si plaka yerini bulmak içindir

resim = imcrop(resimbin, boundingBox); % görüntü üzerinde kýrpma iþlemi yapar.


% plaka yeniden boyutlandýrýrýz.
resim = imresize(resim, [240 NaN]);

resim = imopen(resim, strel('rectangle', [4 4])); % Morfolojik iþlemlerde bir diðer açma iþlemidir


% geniþliði 500'den çok uzun veya çok küçükse bazý nesneleri kaldýrýn
resim = bwareaopen(~resim, 500);
[h, w] = size(resim);
imshow(resim);

Iprops=regionprops(resim,'BoundingBox','Area', 'Image');
count = numel(Iprops);%Iprops öðelerinin sayýsýný döndürür.


for i=1:count
   Iw = length(Iprops(i).Image(1,:));
   Ih = length(Iprops(i).Image(:,1));
   if Iw<(h/2) & Ih>(h/3)
       
       figure; imshow(Iprops(i).Image);
   end
end

% Bu ödev için ihtiyaç duyulan yardýmcý fonksiyonlar 

% 1- imread()
% 2- imresize()
% 3- rgb2gray()
% 4- imbinarize()
% 5- edge()
% 6- imdilate()
% 7- imfill()
% 8- imerode()
% 9- regionprops()
% 10- numel()
% 11- imopen()
% 12- imcrop() 
% 13- bwareaopen()
% 14- size() 


