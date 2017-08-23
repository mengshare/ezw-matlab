%{
���������ݰ�mortonɨ��˳�򽫶�Ӧֵ��������ú���Ϊ�ݹ麯��  
@param Mat ϵ������
@return mls ���� n��1�� ÿ������Ϊ��ӦMat��ֵ
%}
function mls = mat2list(Mat)      
    [r, c]= size(Mat);
    if (r == 2) && (c == 2)%�������2*2������ô�����ֿ�
        mls = [Mat(1,1); Mat(1,2); Mat(2,1); Mat(2,2)];
    else
        M1 = Mat(1 : r / 2, 1 : c/2);
        M2 = Mat(1 : r / 2, c / 2 + 1 : c);
        M3 = Mat(r / 2 + 1 : r, 1 : c / 2);
        M4 = Mat(r / 2 + 1 : r, c / 2 + 1: c);
        lt1 = mat2list(M1);
        lt2 = mat2list(M2);
        lt3 = mat2list(M3);
        lt4 = mat2list(M4);
        mls = [lt1; lt2; lt3; lt4];
    end
end
