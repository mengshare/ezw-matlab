function yasuo2 
clc;
clear;
close all;
X=imread('lena.bmp');

subplot(221);
imshow(X);
title('ԭʼͼ��');
%��ͼ����С�����в�С���ֽ�
[c,s]=wavedec2(X,2,'db1');
%��ȡС���ֽ�ṹ�е�һ��ĵ�Ƶϵ���͸�Ƶϵ��  
ca1=appcoef2(c,s,'db1',1);  
ch1=detcoef2('h',c,s,1);      %ˮƽ����  
cv1=detcoef2('v',c,s,1);      %��ֱ����  
cd1=detcoef2('d',c,s,1);      %б�߷��� 

 %��Ƶ�ʳɷ��ع�  
a1=wrcoef2('a',c,s,'db1',1);  
h1=wrcoef2('h',c,s,'db1',1);  
v1=wrcoef2('v',c,s,'db1',1);  
d1=wrcoef2('d',c,s,'db1',1);  
c1=[ca1,ch1;cv1,cd1];  
subplot(222),imshow(c1,[]);  
title ('�ֽ���Ƶ�͸�Ƶ��Ϣ'); 

 %����ͼ��ѹ��  
%����С���ֽ��һ���Ƶ��Ϣ  
ca1=appcoef2(c,s,'db1',1);  
%���ȶԵ�һ����Ϣ������������  
%ca1=wcodemat(ca1,440,'mat',0);  
%�ı�ͼ��߶Ȳ���ʾ  
ca1=0.5*ca1;  
subplot(223);imshow(uint8(ca1));
title('��һ��ѹ��ͼ��');

%����С���ֽ�ڶ����Ƶ��Ϣ����ѹ��  
ca2=appcoef2(c,s,'db1',2);  
%���ȶԵڶ�����Ϣ������������
%wcodemat��α��ɫ���룬�Բ�ɫͼ����˵û������
%ca2=wcodemat(ca2,440,'mat',0);
%�ı�ͼ��߶Ȳ���ʾ  
ca2=0.25*ca2; 
subplot(224);imshow(uint8(ca2));  
title('�ڶ���ѹ��ͼ��');  
end