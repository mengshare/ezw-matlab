function OutPic=ITwoDimHaar(InPic,J)
[m,n]=size(InPic);
InPic=double(InPic);
OutPic=InPic;
%�жϱ任�߶�
if (2^J>n)
    disp('�߶ȱ任��������������J��');
end
%�ж�����ά������ע�͵�
% if (m~=1)
%     disp('����ά��������������һά���ݣ�');
% end
N=n/(2^(J-1));
M=m/(2^(J-1));
% OutPic=InPic*1.414;
% M=n/2;
for k=1:J
    if ((M==1)||(N==1))
        break;
    else
        %�����б任
        for j=1:N
            for i=1:M/2
                %                 OutPic(i,j)=OutPic(i,j)*1.414;
                %                 InPic=OutPic;
                %�ȳ���1.414�ٱ���2������ֱ�Ӵ���1.414
                OutPic(2*i-1,j)=(InPic(i,j)+InPic(M/2+i,j))/1.414;
                OutPic(2*i,j)=(InPic(i,j)-InPic(M/2+i,j))/1.414;
            end
        end
        InPic=OutPic;
        figure, imshow(OutPic),title('�б任��');
        %�����б任
        for i=1:M
            for j=1:N/2
                %                 OutPic(i,j)=OutPic(i,j)*1.414;
                %                 InPic=OutPic;
                OutPic(i,2*j-1)=(InPic(i,j)+InPic(i,M/2+j))/1.414;
                OutPic(i,2*j)=(InPic(i,j)-InPic(i,M/2+j))/1.414;
            end
        end
        InPic=OutPic;
        figure, imshow(OutPic),title('�б任��');
    end
    N=2*N;
    M=2*M;
end
% OutPic=uint8(OutPic);
% figure,imshow(OutPic),title('�任��ͼ'),imwrite(OutPic,'��任.jpg');