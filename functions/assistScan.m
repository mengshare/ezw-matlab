%{
%��ɨ��
@param imptValue ��Ҫϵ������n��3�� ֵ���С���
@param level int ��n��ɨ��
@param T1 ��ʼ��ֵ
@return quantiList �������� n��5�У���Ҫϵ��ֵ��������־��1��0��������ֵ���С���
%}
function [quantiList, quantiFlag, recvalue, quantifierMat] = assistScan(imptValue, level, T1)
    %��ʼ��
    quantiList = [];
    quantiFlag = [];
    recvalue = [];
    
    %��ȡ������
    [quantifierMat, threshold] = quantifier(T1, level);

    [imRow, imCol] = size(imptValue);
    for j=1 : imRow
        rI = floor(imptValue(j) / threshold);%���ҳ����ĸ�����
        flag01 = imptValue(j) - rI*threshold;
        if flag01 < threshold / 2
            quantiFlag = [quantiFlag ; 0];
            recvalue = [recvalue ; quantifierMat(rI, 1)];
        else
            quantiFlag = [quantiFlag ; 1];
            recvalue = [recvalue ; quantifierMat(rI , 2)];
        end
    end
    quantiList = [imptValue(:, 1), quantiFlag, recvalue, imptValue(:, 2), imptValue(:, 3)];
end