function OutPic=TwoDimHaar(InPic,J) %����������In��j�߶ȵ�һά��ɢС���任
%�ж���������in�Ƿ�Ϊһά���У�������ִ��
[m,n]=size(InPic);
InPic=double(InPic);
%������һλС���任���ж�������ע�͵�o(��_��)o...
% if(m~=1)
%     disp('������һά���У�');
% end
%�ж����������������ֻ��һ������jֵĬ��Ϊ1
if nargin==1
    J= 1;
end;
OutPic=InPic;
%����J���߶ȹ���С���任
N=n/2;
M=m/2;
for k=1:J
    %����С���б任
    for i=1:m
        for j=1:N
            OutPic(i,j)=[InPic(i,2*j-1)+InPic(i,2*j)]/1.414;
            OutPic(i,N+j)=[InPic(i,2*j-1)-InPic(i,2*j)]/1.414;
        end
    end
    figure,imshow(OutPic),title('�б任��');

    %�ж��Ƿ�ʣһ������
    if(N==1)
        disp('�����任��ʱֻʣһ������');
    end
    InPic=OutPic;
    %�����б任
    for j=1:n
        for i=1:M
            OutPic(i,j)=[InPic(2*i-1,j)+InPic(2*i,j)]/1.414;
            OutPic(M+i,j)=[InPic(2*i-1,j)-InPic(2*i,j)]/1.414;
        end
    end


    %�ж��Ƿ�ʣһ������
    if(M==1)
        disp('�����任��ʱֻʣһ������');
    end
    M=M/2;
    N=N/2;
    m=m/2;
    n=n/2;
    InPic=OutPic;
    figure,imshow(OutPic),title('�б任��');
end
OutPic=uint8(OutPic);
%��ʾ���任���ͼ����Ϊ�任��ͼ���������ÿ�����ؼ�100������������
figure,imshow(abs(OutPic)+100),title('�任��ͼ'),imwrite(OutPic,'�任.jpg');
