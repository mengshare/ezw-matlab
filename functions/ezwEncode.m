%{
Ƕ��ʽ����С�����뺯��
@param scanTimes int ɨ�����
@param cAll ϵ������
@return scanCodes ÿ����ɨ�����ݼ���
@return quantiFlags ÿ�θ�ɨ�����ɵ���Ҫϵ����־���ϣ�0/1���м��ϣ�
@return perScanNums ��¼ÿ��ɨ���scanCode������quantiFlag����,
perScanNums��1,1����ɨ�������perScanNums��1,2���ǳ�ʼ��ֵ��������Կ���ȥ������
����ÿ��2��ֵ����¼canCode������quantiFlag����
%}

function [scanCodes, quantiFlags, perScanNums] = ezwEncode(cAll, T, scanTimes, handles)
    global row col;
    %��ȡɨ������
    scanList = morton(cAll);

    %��ʼ��
    flagList(1 : row, 1 : col) = 'Z';
    imptValue = [];
    imptFlag = [];
    scanCodes = '';%����ÿ����ɨ���scanCode
    quantiFlags = [];%����ÿ�θ�ɨ���quantiFlag
    perScanNums = [];
    
    for i = 1 : scanTimes
        set(handles.text6, 'string', ['�����������ڽ��е�' num2str(i) '�α���']);
        pause(0.1);
        %��ɨ��
        [imptValue, imptFlag, scanCode, flagListBak, flagList] = mainScan(cAll, scanList, flagList, imptValue, imptFlag, T(i));
        scanCodes = [scanCodes scanCode];
        %��ɨ��
        [quantiList, quantiFlag, recvalue, quantifierMat] = assistScan(imptValue, i, T(1));
        quantiFlags = [quantiFlags quantiFlag'];
        perScanNums = [perScanNums ; length(scanCode) length(quantiFlag)];
    end
    %�������

end