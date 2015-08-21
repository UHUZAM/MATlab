

%%Spot 7 üzerinden alýnan görüntünün 7 temel bandý okunarak 
%%coðrafi bilgiler fotoðraftan ayrýþtýrýlýr.
[A1, R1] = geotiffread('LE72030302015098NSG00_B1.TIF');
[A2, R2] = geotiffread('LE72030302015098NSG00_B2.TIF');
[A3, R3] = geotiffread('LE72030302015098NSG00_B3.TIF');
[A4, R4] = geotiffread('LE72030302015098NSG00_B4.TIF');
[A5, R5] = geotiffread('LE72030302015098NSG00_B5.TIF');
[A6, R6] = geotiffread('LE72030302015098NSG00_B6_VCID_1.TIF');
[A7, R7] = geotiffread('LE72030302015098NSG00_B7.TIF');
[A8, R8] = geotiffread('LE72030302015098NSG00_B8.TIF');

%3 katmanlý fotoðraf oluþturma, sýralama layerlarýn önceliðini
%etkilemektedir.
compositeImage = cat(3,A1,A2,A3);
compositeImage2= cat(3,A4,A5,A6);
compositeImage3= cat(3,A5,A6,A7);
compositeImage4= cat(3,A4,A3,A2);
%%oluþturulan 3 katmanlý fotoðrafý yazdýrma
imwrite( compositeImage3, 'karsilastirma.tif');
imwrite( compositeImage4, 'karsilastirma2.tif');
RGB=cat(3,A4,A3,A2);
compositeImage5 = cat(3,compositeImage,A4,A5);
compositeImage6 = cat(3,compositeImage,compositeImage2,A7);
[X, R] = geotiffread('LE72030302015098NSG00_B2.tif');
%%info deðiþkenine coðrafi koordinatlar atanýr
info = geotiffinfo('LE72030302015098NSG00_B2.tif');
%%coðrafi koordinat etiketli geotiff dosyasý oluþturma, mapraster uzantýsý
% direk kullanýlamadýðýndan GeoKeyDirectoryTag',
% info.GeoTIFFTags.GeoKeyDirectoryTag kullanýlmasý gerekmektedir.

geotiffwrite('outfile.tif', compositeImage6, R1, ...
 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag); 


