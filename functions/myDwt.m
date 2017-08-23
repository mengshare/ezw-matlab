%{
 һάdwt
@param X һά����
@param lpd ��ͨ�˲�
@param hpd ��ͨ�˲�

@return ca ��Ƶϵ��/����ϵ��
@return cd ��Ƶϵ��/��ȷϵ��
%}
function [ca, cd] = myDwt(X, lpd, hpd)
    ca = X;
    cd = [];
    t = ca;
    %��ȡ��Ƶϵ��
    z = conv(t, lpd);
    last = floor(length(z));
    ca = z(2 : 2 : last);
    %��ȡ��Ƶϵ��
    z = conv(t, hpd);
    last = floor(length(z));
    cd = [cd z(2 : 2 : last)];
end