function cAllDecode = ezwDecode(T1, decodeDim, CodeList, LenSubCL, QuantiFlagList, LenSubQFL, handles)
    global row col
    recvalue = [];
    rIlist = [];
    quantiFlagOld = [];
    scanorder = listOrder(row, col, 1, 1);
    flagMat(1 : row, 1 : col) = 'Z';

    for level=1 : decodeDim
         set(handles.text6, 'string', ['�����������ڽ��е�' num2str(level) '�ν���']);
         pause(0.1);
        %��ȡ��ǰ���ɨ�����������־�������ƶ��еķ�ʽȡ��
        scancode = CodeList(1 : LenSubCL(level));
        CodeList = CodeList(LenSubCL(level) + 1 : end);
        quantiflag = QuantiFlagList(1 : LenSubQFL(level));
        QuantiFlagList = QuantiFlagList(LenSubQFL(level) + 1 : end);

        cAllDecode(1 : row, 1 : col) = 0;
        qrNum = 1;%��¼quantiflag���ڼ���
        scNum = 1;%��¼scancode���ڼ���
        %��ȡ���������������ϼ����ȣ�����
        [antiQuantiMat, rIlist, quantiFlagOld] = antiquantifier(T1, level, rIlist, quantiflag, quantiFlagOld);
        [cAllDecode, recvalue, qrNum] = updateRecvalue(cAllDecode, recvalue, qrNum, quantiflag, antiQuantiMat, rIlist);
        [cAllDecode,flagMat,recvalue] = decoding(cAllDecode, flagMat, recvalue, antiQuantiMat, quantiflag, rIlist, scanorder, scancode, scNum, qrNum);
        
        global Y s;
        c = mat2c(cAllDecode, s);
        Y = waverec2(c, s, 'db1');
        Y = uint8(Y);
        axes(handles.axes2);
        imshow(Y);
        title('ѹ�����ͼ��');
        pause(0.1);
    end
end

%{
����
@param cAllDecode ϵ������
@param flagMat ϵ������ÿ�����Ӧ������
@param recvalue ��Ҫϵ�� ֵ+����
@param antiQuantiMat ��������
@param quantiflag ɨ�����ж�Ӧ������ֵ
@param rIlist quantiflag��Ӧ�ĵȼ�
@param scanorder ɨ������
@param scNum 
@param qrNum ��ǰִ�е�quantiflag�ĵڼ�λ
%}
function [cAllDecode, flagMat, recvalue] = decoding(cAllDecode, flagMat, recvalue, antiQuantiMat, quantiflag, rIlist, scanorder, scancode, scNum, qrNum)
    global row col
    for r = 1 : row * col
        if flagMat(scanorder(r, 1), scanorder(r, 2)) == 'O'
            continue;
        elseif flagMat(scanorder(r, 1), scanorder(r, 2))=='X'
            continue;
        else
            if scancode(scNum) == 'P'
                flagMat(scanorder(r, 1), scanorder(r, 2)) = 'P';
                if quantiflag(qrNum) == 1
                    qValue = antiQuantiMat(rIlist(qrNum), 2);
                    recvalue = [recvalue ; qValue, scanorder(r, 1), scanorder(r, 2)];
                    cAllDecode(scanorder(r, 1), scanorder(r, 2)) = qValue;
                    qrNum = qrNum + 1;
                else
                    qValue = antiQuantiMat(rIlist(qrNum), 1);
                    recvalue = [recvalue ; qValue, scanorder(r, 1), scanorder(r, 2)];
                    cAllDecode(scanorder(r, 1), scanorder(r, 2)) = qValue;
                    qrNum = qrNum+1;
                end
                scNum = scNum + 1;
            elseif scancode(scNum) == 'N'
                flagMat(scanorder(r, 1), scanorder(r, 2)) = 'N';
                if quantiflag(qrNum) == 1
                    qValue = -antiQuantiMat(rIlist(qrNum), 2);
                    recvalue = [recvalue;qValue,scanorder(r, 1), scanorder(r, 2)];
                    cAllDecode(scanorder(r, 1),scanorder(r, 2)) = qValue;
                    qrNum = qrNum + 1;
                else
                    qValue=-antiQuantiMat(rIlist(qrNum),1);
                    recvalue=[recvalue;qValue,scanorder(r,1),scanorder(r,2)];
                    cAllDecode(scanorder(r,1),scanorder(r,2))=qValue;
                    qrNum=qrNum+1;
                end
                scNum=scNum+1; 
            elseif scancode(scNum) == 'Z'
                cAllDecode(scanorder(r, 1), scanorder(r, 2)) = 0;
                scNum = scNum + 1;
            elseif scancode(scNum) == 'T'
                flagMat(scanorder(r, 1), scanorder(r, 2)) = 'T';
                cAllDecode(scanorder(r, 1), scanorder(r, 2)) = 0;
                chTree=treeMat(scanorder(r, 1), scanorder(r, 2));
                [rowch, colch] = size(chTree);
                for rc = 1 : rowch
                    if flagMat(chTree(rc, 1), chTree(rc, 2)) ~= 'O'
                        flagMat(chTree(rc, 1), chTree(rc, 2)) = 'X';
                    end
                end
                scNum = scNum + 1;
            end
        end
    end
    Decodeflag = flagMat;
    for i=1:row
        for j=1:col
            switch flagMat(i, j)
                case {'P','N'}
                    flagMat(i,j) = 'O';
                case {'T','X'}
                    flagMat(i,j) = 'Z';
            end
        end
    end
end