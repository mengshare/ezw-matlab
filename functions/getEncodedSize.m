
%{
@param perScanNums ��¼ÿ��ɨ���scanCode������quantiFlag����,
@param dim �ֽ⼶��
%}
function fileSizeOut = getEncodedSize(perScanNums, scanTimes)
    fileSizeOut = 0;
    for i = 1 : scanTimes
        %�����ַ�������ÿ���ַ�2����
        fileSizeOut = perScanNums(i, 1) * 2 + perScanNums(i, 2);
        fileSizeOut = fileSizeOut / 8 / 1024;
    end
end