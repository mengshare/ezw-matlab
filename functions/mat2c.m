
%{
��С���任���ϵ���ɾ����ʽת��Ĭ�ϸ�ʽ---Ϊc2mat���溯��
@param cAllDecode ��ת��ϵ������
@param s С���任��Ĳ���

@return c С���任��Ĳ�����������ʽ
%}
function c = mat2c(cAllDecode, s)
    c = [];
    %��ת����Ƶϵ��
    for perColumn = 1 : s(1, 2)
        %�Ȱ��к��������
            for perRow = 1 : s(1, 1)
                c = [c cAllDecode(perRow, perColumn)];
            end
    end
    
    for i = 2 : length(s) - 1
        %ת��ˮƽ��Ƶϵ��
        for perColumn = 1 : s(i, 2)
            for perRow = 1 : s(i, 1)
                c = [c cAllDecode(perRow , perColumn + sum(s(1 : i - 1,2)))];
            end
        end
        
        %ת����ֱ��Ƶϵ��
        for perColumn = 1 : s(i, 2)
            for perRow = 1 : s(i, 1)
                c = [c cAllDecode(perRow + sum(s(1 : i - 1,1)), perColumn)];
            end
        end
        %ת��б�Ǹ�Ƶϵ��
        for perColumn = 1 : s(i, 2)
            for perRow = 1 : s(i, 1)
                c = [c cAllDecode(perRow + sum(s(1 : i - 1,1)), perColumn + sum(s(1 : i - 1,2)))];
            end
        end
    end
end