

%%Spot 7 �zerinden al�nan g�r�nt�n�n 7 temel band� okunarak 
%%co�rafi bilgiler foto�raftan ayr��t�r�l�r.
[A1, R1] = geotiffread('LE72030302015098NSG00_B1.TIF');
[A2, R2] = geotiffread('LE72030302015098NSG00_B2.TIF');
[A3, R3] = geotiffread('LE72030302015098NSG00_B3.TIF');
[A4, R4] = geotiffread('LE72030302015098NSG00_B4.TIF');
[A5, R5] = geotiffread('LE72030302015098NSG00_B5.TIF');
[A6, R6] = geotiffread('LE72030302015098NSG00_B6_VCID_1.TIF');
[A7, R7] = geotiffread('LE72030302015098NSG00_B7.TIF');
[A8, R8] = geotiffread('LE72030302015098NSG00_B8.TIF');

%3 katmanl� foto�raf olu�turma, s�ralama layerlar�n �nceli�ini
%etkilemektedir.
compositeImage = cat(3,A1,A2,A3);
compositeImage2= cat(3,A4,A5,A6);
compositeImage3= cat(3,A5,A6,A7);
compositeImage4= cat(3,A4,A3,A2);
%%olu�turulan 3 katmanl� foto�raf� yazd�rma
imwrite( compositeImage3, 'karsilastirma.tif');
imwrite( compositeImage4, 'karsilastirma2.tif');
RGB=cat(3,A4,A3,A2);
compositeImage5 = cat(3,compositeImage,A4,A5);
compositeImage6 = cat(3,compositeImage,compositeImage2,A7);
[X, R] = geotiffread('LE72030302015098NSG00_B2.tif');
%%info de�i�kenine co�rafi koordinatlar atan�r
info = geotiffinfo('LE72030302015098NSG00_B2.tif');
%%co�rafi koordinat etiketli geotiff dosyas� olu�turma, mapraster uzant�s�
% direk kullan�lamad���ndan GeoKeyDirectoryTag',
% info.GeoTIFFTags.GeoKeyDirectoryTag kullan�lmas� gerekmektedir.

geotiffwrite('outfile.tif', compositeImage6, R1, ...
 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag); 


