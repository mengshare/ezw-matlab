%{
�ж�ĳ�ڵ��Ƿ�Ϊ��Ҫϵ��
@param Mat ϵ������
@param chRows int �к�
@param chCols   int �к�
@param threshold int ��ֵ

@return chImt int 1/0
@return chMat ����ڵ����n��3�У��С��С�ֵ
%}
function  [chImt, chMat] = childImportant(Mat, chRows, chCols, threshold)
    chMat = childMat(Mat,chRows,chCols);
    if max(abs(chMat(:, 3))) >= threshold %chMat�����м�Ϊϵ��ֵ
        chImt = 1;
    else
        chImt = 0;
    end
end