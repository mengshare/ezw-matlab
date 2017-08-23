%{
�����һ���������Ҫϵ�����ع�����
@param cAllDecode �������ϵ����Ӧֵ
@param recvalue ��֪����Ҫϵ��ֵ
@param qrNum ��ǰ���е�quantiflag�ĵڼ�����
@param antiQuantiMat ��������
@param rIlist ������ ��ǰ��quantiFlagÿ��ֵ����Ӧ�ľ��������ȼ���һ����level^2-1���ȼ���
%}
function [cAllDecode, recvalue, qrNum] = updateRecvalue(cAllDecode, recvalue, qrNum, quantiflag, antiQuantiMat, rIlist)
    if ~isempty(recvalue)
        [rvRow, rvCol] = size(recvalue);
        for i = 1 : rvRow
            if quantiflag(qrNum) == 1
                qValue = antiQuantiMat(rIlist(qrNum), 2);
                if recvalue(i) < 0
                    qValue = -qValue;
                end
                recvalue(i,1)=qValue;
                % recvalue����ĵ�2��3�д�����Ƕ�Ӧ��DecodeMat�е��С��кţ�r,c��
                cAllDecode(recvalue(i,2),recvalue(i,3))=qValue;  
                qrNum = qrNum + 1;
            else %quantiflag(qrNum) == 0
                qValue = antiQuantiMat(rIlist(qrNum), 1);
                if recvalue(i)<0
                    qValue=-qValue;
                end
                recvalue(i,1)=qValue;
                cAllDecode(recvalue(i,2),recvalue(i,3))=qValue;
                qrNum=qrNum+1;
            end
        end
    end
end