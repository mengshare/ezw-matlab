%{
��ȡ��������������
@param T1 int ��ʼ��ֵ
@param level int ��ǰɨ�����
@param rIlist ������ ��ǰ��quantiFlagÿ��ֵ����Ӧ�ľ��������ȼ���һ����level^2-1���ȼ���
@param quantiFlag ������ ������־�б�
@param quantiFlagOld ��һ��ѭ����quantiFlag
@return antiQuantiMat ���������󣬱������ÿһ�������ȼ�����ֵ����Ӧ����������ֵ
@return rIlist ���ϣ������ֵ�볤��������
@return quantiFlagOld �봫������quantiFlagֵ���
%}

function [antiQuantiMat, rIlist, quantiFlagOld] = antiquantifier(T1, level, rIlist, quantiFlag, quantiFlagOld)
    antiQuantiMat = [];
    maxInterValue = 2 * T1;
    threshold = T1 / 2 ^ (level - 1);
    intervalNum = maxInterValue / threshold - 1;
    for i = 1 : intervalNum
        antiQuantiMat = [antiQuantiMat ; threshold * (i + 0.25) threshold * (i + 0.75)];
    end

    %��ȡR�б���һ�γ��ֵĶ���1
    rIlen = length(rIlist);
    flaglen = length(quantiFlag);
    for r = 1 : rIlen
        rIlist(r) = 2 * rIlist(r) + quantiFlagOld(r);
    end
    for f = rIlen + 1 : flaglen
        rIlist(f) = 1;
    end
    quantiFlagOld = quantiFlag;
end