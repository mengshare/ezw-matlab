%��С���������ƣ�dbN��symN��coifN������С���������г߶Ⱥ����ģ�ֻ����N���У���
[phi,psi,x] = wavefun('haar',10);%����ʹ��10�����ϵ������㣬�ȽϾ�ȷ
subplot(221),plot(x,psi);
title('haarС������');

[phi,psi,x] = wavefun('db4',10);
subplot(222),plot(x,psi);
title('db4С������');

[phi,psi,x] = wavefun('sym6',10);
subplot(223),plot(x,psi);
title('sym6С������');

[phi,psi,x] = wavefun('coif2',10);
subplot(224),plot(x,psi);
title('coif2С������');