%{
��ȡ����˳���б����ú���Ϊ�ݹ麯��
@param mr ����
@param mc ����
@param pr  ��ʼ��
@param pc  ��ʼ��
@return lsorder n��2�еľ���
%}
function lsorder = listOrder(mr, mc, pr, pc)      
    lso = [pr, pc; pr, pc + mc / 2; pr + mr / 2, pc; pr + mr / 2, pc + mc / 2];  
    mr = mr/2;
    mc = mc/2;   
    lm1=[];
    lm2=[];
    lm3=[];
    lm4=[];  
    if (mr > 1) && (mc > 1)      
        ls1 = listOrder(mr, mc, lso(1, 1), lso(1, 2));    
        lm1 = [lm1 ; ls1];
        ls2 = listOrder(mr, mc, lso(2, 1), lso(2, 2));
        lm2 = [lm2 ; ls2];
        ls3 = listOrder(mr, mc, lso(3, 1), lso(3, 2));
        lm3 = [lm3 ; ls3];
        ls4 = listOrder(mr, mc, lso(4, 1), lso(4, 2));
        lm4 = [lm4 ; ls4];
    end
    %����lsoҪ���ݣ�����ÿ��ȡ���mr * mc * 4�ĳ��ȣ�����mr��mc���ֱ��2�ˣ�����Ҫ��4��
    lsorder = [lso ; lm1 ; lm2 ; lm3 ; lm4];
    len = length(lsorder);
    lsorder = lsorder(len - mr * mc * 4 + 1 : len, 1 : 2);
end
