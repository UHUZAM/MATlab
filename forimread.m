ImageFiles = dir('C:\Users\Gurkan\Desktop\earth\Landsat8\*.tif')
for k=1:length(ImageFiles)
   % Ýlk resimle baþlayarak okuma
    [Data, R] = geotiffread(['C:\Users\Gurkan\Desktop\earth\Landsat8\',ImageFiles(k).name]); 
   I= imcrop(Data,[5250 3850 1000 1000 ]);
   [rows columns] = size(I);
   Re= reshape(I,[rows*columns,1]);
   A(:,k)= (Re);
end

A=single(A);
    [n m] = size(A);
    AMean = mean(A,2);
    B = (A - repmat(AMean,[1 m]));
    % Dagilimin kovaryansini bul
    clearvars Data Re
C=cov(B);
% Ozdegerler (D) ve ozvektorleri (V) bul
% Hatirla ki: A*V = V*D ve V'nin her sutunu bir ozvektor
[V,D] = eig(C);
D = diag(D);
% Ozdegerleri buyukten kucuge siralamak gerekli. Matlab tersinden
% buldugu icin degerleri ters dondur.
D = flipud(D); % Sutun vektorunu altust et
V = fliplr(V); % Matrisin sagdan sola aynasini al
V(:,11)=[];
PC=B * V;
ans1=norm(PC(:,1));
n1=PC(:,1)./ans1;
ans2=norm(PC(:,2));
n2=PC(:,2)./ans2;
ans3=norm(PC(:,3));
n3=PC(:,3)./ans3;
ans4=norm(PC(:,4));
n4=PC(:,4)./ans4;
ans5=norm(PC(:,5));
n5=PC(:,5)./ans5;
ans6=norm(PC(:,6));
n6=PC(:,6)./ans6;
ans7=norm(PC(:,7));
n7=PC(:,7)./ans7;
ans8=norm(PC(:,8));
n8=PC(:,8)./ans8;
ans9=norm(PC(:,9));
n9=PC(:,9)./ans9;
ans10=norm(PC(:,10));
n10=PC(:,10)./ans10;

PC2=[n1,n2,n3,n4,n5,n6,n7,n8,n9,n10];
save('PCcrop.mat', 'PC2');
clearvars PC n1 n2 n3 n4 n5 n6 n7 n8 n9 n10
OrjA=((B * V) * V')+repmat(AMean,[1 m]); %% denklemi kullanýlabilir.
birim=corrcoef(PC2); %%  birim matris oluþturma

%%Re= reshape(A1,[rows*columns,1]);
%%Re2=reshape(Re, [rows, columns]);
%%%imshow(Re2)  
im=OrjA(:,[1]);
im2=reshape(im,[rows,columns]);
im2=uint16(im2);
figure
imshow(im2)
title('After PCA')

d=A(:,[1]);
d2=reshape(d,[rows,columns]);
d2=uint16(d2);
figure
imshow(d2)
title('Before PCA')


%%output = double(image1) + double(image2) + double(image3) + double(image4) + double(image5);