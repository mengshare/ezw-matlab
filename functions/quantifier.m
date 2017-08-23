%{
%����������
@param T1 int ��ʼ��ֵ
@param level int ��n��ɨ��

@return quantifierMat ÿ�������ֵn������
@return threshold ��ǰ��ֵ
%}
function [quantifierMat, threshold] = quantifier(T1, level)
    quantifierMat = [];
    maxInterValue = 2 * T1;
    threshold = T1 / 2 ^ (level - 1);%��level��ɨ�����ֵ
    intervalNum = maxInterValue / threshold - 1;%��������Ŀ����ʼ�㲻��0���Լ�1
    for i = 1 : intervalNum
        quantifierMat = [quantifierMat ; threshold * (i + 0.25) threshold * (i + 0.75)];
    end
end