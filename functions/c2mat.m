
%{
��С���任���ϵ����ʽת���ɾ�����ʽ
@param cai ������Ƶϵ��
@param c С���任��Ĳ�����������ʽ
@param s С���任��Ĳ���
@param dim �ֽ����

@return cai ������ɵ��ܵ�ϵ������
%}
function cai = c2mat(cai, c, s, dim) 
    %��ȡÿ��ĸ�Ƶϵ��
    for i = 1 : dim
        [chn, cvn, cdn] = detcoef2('all', c, s, dim + 1 - i);%ˮƽ����   %��ֱ����  %б�߷��� 
        cai = [cai, chn; cvn, cdn];
    end
end