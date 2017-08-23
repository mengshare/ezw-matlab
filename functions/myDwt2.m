%{
��άdwt
@param X ��ά����
@param lpd ��ͨ�˲�
@param hpd ��ͨ�˲�

@return ca ch cv cd�ĸ����ֵ�ϵ��
%}
function [ca, ch, cv, cd] = myDwt2(X, lpd, hpd)
    
    %�б任
    [row, col] = size(X);
    cRow = [];
    for i = 1 : row
        perRow = X(i, :);
        [cai, cdi] = myDwt(perRow, lpd, hpd);
        % perRow ����Ϊro���˲�������Ϊ lf
        % �� [cai, cdi] ���ܳ�Ϊ 2*floor(( row + lf -1 )/2)
        cRow(i, :) = [cai cdi];
    end
    
    %�б任
    [row, col] = size(cRow);
    cAll = [];
    for j = 1 : col
        perCol = cRow(:, j)';%ע��ת��
        [cai, cdi] = myDwt(perCol, lpd, hpd);
        cAll(:, j) = [cai cdi]';%ע��ת��
    end
    
    [row, col] = size(cAll);
    ca = cAll(1 : floor(row / 2),           1 : floor(col / 2));              % ca�Ǿ���cAll�����Ͻǲ���
    ch = cAll(floor(row / 2) + 1 : row, 1 : floor(col / 2));             % ch�Ǿ���cAll�����½ǲ���
    cv = cAll(1 : floor(row / 2),            floor(col / 2) + 1 : col);    % cv�Ǿ���cAll�����Ͻǲ���
    cd = cAll(floor(row / 2) + 1 : row, floor(col / 2) + 1 : col);    % cd�Ǿ���cAll�����½ǲ���
end