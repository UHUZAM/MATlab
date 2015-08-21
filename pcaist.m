I=imread('Istanbul2.tif');
%%for i=1:4;
   %% SPCrater_321_stretch(:,:,i)=histeq(I(:,:,i));
%%end

A=single(I);
[rows columns band] = size(A);
Re= reshape(A,[rows*columns,4]);
AMean = mean(Re,2);
B = (Re - repmat(AMean,[1 4]));

C=cov(B);
% Ozdegerler (D) ve ozvektorleri (V) bul
% Hatirla ki: A*V = V*D ve V'nin her sutunu bir ozvektor
[V,D] = eig(C);
D = diag(D);
% Ozdegerleri buyukten kucuge siralamak gerekli. Matlab tersinden
% buldugu icin degerleri ters dondur.
D = flipud(D); % Sutun vektorunu altust et
V = fliplr(V); % Matrisin sagdan sola aynasini al

PC=B * V;
ans1=norm(PC(:,1));
n1=PC(:,1)./ans1;
ans2=norm(PC(:,2));
n2=PC(:,2)./ans2;
ans3=norm(PC(:,3));
n3=PC(:,3)./ans3;
ans4=norm(PC(:,4));
n4=PC(:,4)./ans4;


PC2=[n1,n2,n3,n4];
save('PCist.mat', 'PC2');
OrjA=((B * V) * V')+repmat(AMean,[1 4]);
birim=corrcoef(PC2);
d=Re(:,[2]);
d2=reshape(d,[rows,columns]);
d2=uint16(16*d2);
figure
imshow(d2)
title('Before PCA')

im=OrjA(:,[2]);
im2=reshape(im,[rows,columns]);
im2=uint16(16*im2);
figure
imshow(im2)
title('After PCA')


[x1, y1] = ginput2(25)
x1 = round(x1);
y1 = round(y1);
      
Row1=bsxfun(@times,x1,y1);

[x2, y2] = ginput2(25)
x2 = round(x2);
y2 = round(y2);
Row2=bsxfun(@times,x2,y2);

[x3, y3] = ginput2(25)
x3 = round(x3);
y3 = round(y3);
Row3=bsxfun(@times,x3,y3);

[X,Y,BUTTON,SCALEMAT] = ginput2(25)

x4 = round(X);
y4 = round(Y);
Row4=bsxfun(@times,x4,y4);

for i=1:25
   
   a1(:,i)=PC2(Row1(i),:)';
   
end
a1=a1'
for i=1:25
   
   a2(:,i)=PC2(Row2(i),:)';
   
end
a2=a2'
for i=1:25
   
   a3(:,i)=PC2(Row3(i),:);
   
end
a3=a3'
for i=1:25
   
   a4(:,i)=PC2(Row4(i),:);
   
end
a4=a4'
Train=([a1;a2;a3;a4]);
train_data1=Train';
train_data1=train_data1(1:4,:);
save 'Trainist_100.mat' 'Train' 'train_data1'
class_data = [ones(1,25), 2*ones(1,25), 3*ones(1,25), 4*ones(1,25)];
class_data=single(class_data);
out = permute(reshape(PC2, rows,columns,[]),[1 2 3]);
cluster1_result = cvParallelepiped(out, train_data1, class_data, 1.15);
test_image1=single(zeros(rows,columns,3));
test1 = cluster1_result;
cluster1_1=single(255*(test1 == 0)); %Sea
cluster1_2 =ismember(cluster1_result,[8 9 15 16]);%Forest
cluster1_2 = single(255*cluster1_2);
cluster1_3 = single(255*(test1 == 5)); %City
cluster1_4 = single(255*(test1 == 7)); %Ground
test_image1(:,:,2) = cluster1_2 + (0.5)*cluster1_3; %+ cluster1_4;
test_image1(:,:,1) = cluster1_4 + (0.5)*cluster1_3; %+ cluster1_4;
test_image1(:,:,3) = cluster1_1 + (0.5)*cluster1_3;

figure;
imshow(uint8(test_image1));

save 'PC2.mat' 'PC2';