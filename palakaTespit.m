

resim = imread('plaka resmi ad�'.'format'); //plaka.jpeg/png/jpg
resim = imresize(resim, [480 NaN]); % resmi istenilen b�yuta ayarl�yoruz
resimgray = rgb2gray(resim);
resimbin = imbinarize(resimgray);
resim = edge(resimgray, 'sobel');

resim = imdilate(resim, strel('diamond', 2));% imdilate ile strel ile yap�lan morfolojik i�lemlerin
%a�ma i�lemini ger�ekle�tirdik. Kapama i�lemi ise imeorde ile
%yap�lmaktad�r.

resim = imfill(resim, 'holes');% morfolojik i�lemelerden gelen istenmeyen bo�luklar�n doldurulmas� 
%i�lemlerin� imfill ile yap�yoruz. Yaparkende diyoruz ki bo�luklar� holes
%adl� �zelli�i ile doldur veya d�zelt.(Bo�luktan kas�t g�r�lt�)

resim = imerode(resim, strel('diamond', 10)); %Morfolojik i�lmelerde kapama i�lemi yap�ld�.


Iprops=regionprops(resim,'BoundingBox','Area', 'Image'); % Burada kullan�lan regionprops �zelli�i ile de
%g�r�nt�de almak istedi�imiz nesneleri kopar�p ayr� fig�re olarak
%g�stermeye �al��t�k.
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

% Yukar�daki ad�m�n% 'si plaka yerini bulmak i�indir

resim = imcrop(resimbin, boundingBox); % g�r�nt� �zerinde k�rpma i�lemi yapar.


% plaka yeniden boyutland�r�r�z.
resim = imresize(resim, [240 NaN]);

resim = imopen(resim, strel('rectangle', [4 4])); % Morfolojik i�lemlerde bir di�er a�ma i�lemidir


% geni�li�i 500'den �ok uzun veya �ok k���kse baz� nesneleri kald�r�n
resim = bwareaopen(~resim, 500);
[h, w] = size(resim);
imshow(resim);

Iprops=regionprops(resim,'BoundingBox','Area', 'Image');
count = numel(Iprops);%Iprops ��elerinin say�s�n� d�nd�r�r.


for i=1:count
   Iw = length(Iprops(i).Image(1,:));
   Ih = length(Iprops(i).Image(:,1));
   if Iw<(h/2) & Ih>(h/3)
       
       figure; imshow(Iprops(i).Image);
   end
end

% Bu �dev i�in ihtiya� duyulan yard�mc� fonksiyonlar 

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


