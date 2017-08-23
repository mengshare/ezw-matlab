%{
��ɨ��
@param Mat ϵ������
@param scanList ɨ������n��4�У�id �к� �к� ��Ӧϵ��ֵ
@param flagList ɨ���Ǳ���С��ϵ������һ������¼����ÿ��ϵ��������
@param imptValue ��Ҫϵ��ֵ�б�n��3�У�ֵ���У���
@param imptFlag ��Ҫϵ����־��P��N��ɵ�һ��
@param threshold ����ɨ����ֵ

@return imptValue ͬ��
@return imptFlag ͬ��
@return scanCode �Ա���ɨ����Ľڵ��������ļ�¼����������P��N��Z��T
@return flagListBak Ϊ��ɨ�����flagList�ı���
@return flagList ��ɨ����ֵ�ĳ�O����Z���֣���Ҫ���߲���Ҫ��������һ��ɨ��ʹ��
%}
function  [imptValue, imptFlag, scanCode, flagListBak, flagList] = mainScan(Mat, scanList, flagList, imptValue, imptFlag, threshold) 
    global row col ;
    scanCode=[];
    for i = 1 : row * col
        if flagList(scanList(i, 2), scanList(i, 3)) == 'O' %��Ҫϵ������������ڵڶ���ɨ��ʱ�õ�
            continue; 
        elseif abs(scanList(i, 4)) >= threshold %����ֵ�Ƚ�
            if scanList(i,4)>=0 %����Ҫϵ��
                flagList(scanList(i,2), scanList(i,3))='P';
                scanCode  = [scanCode 'P'];
                imptValue = [imptValue ; abs(scanList(i,4)), scanList(i,2), scanList(i,3)];
                imptFlag = [imptFlag 'P'];
            else %����Ҫϵ��
                flagList(scanList(i,2),scanList(i,3))='N';
                scanCode=[scanCode 'N']; 
                imptValue=[imptValue;abs(scanList(i,4)),scanList(i,2),scanList(i,3)];
                imptFlag=[imptFlag 'N'];
            end
        else %����ֵС��
            if flagList(scanList(i,2),scanList(i,3))=='X'  %����������ֱ������
                continue;
            elseif i > row*col/4 %���ڵ�һ�ֽ⼶��û������ϵ��
                scanCode=[scanCode 'T'];
            else %�ж�����ڵ��Ƿ���ڱ���ֵ���
                [chImt,chMat] = childImportant(Mat, scanList(i,2), scanList(i,3), threshold);
                if chImt %�������
                    flagList(scanList(i,2),scanList(i,3))='Z';
                    scanCode=[scanCode 'Z'];
                else %����
                    flagList(scanList(i,2),scanList(i,3))='T';
                    scanCode=[scanCode 'T'];
                    [rowch,colch]=size(chMat);
                    for r=1:rowch
                        if flagList(chMat(r,1), chMat(r,2)) ~= 'O'
                            flagList(chMat(r,1), chMat(r,2)) = 'X';
                        end
                    end
                end
            end
        end
    end
    flagListBak=flagList;
    for r=1:row
        for c=1:col
            switch flagList(r,c)
                case {'P','N'}
                    flagList(r,c)='O';
                case {'X','T'}
                    flagList(r,c)='Z';
            end
        end
    end
end

