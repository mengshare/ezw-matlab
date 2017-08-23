

%{
������ͼ��X�����޼���ʹ���䳤���ܱ�2^dim����
%}
function X = sizePrune(X, dim)
    %��X�����޼���ʹ���ܱ�2^dim����
    divide = 2 ^ dim;
    sizeX = size(X);
    for i = sizeX(1)  : -1 : 1
        if  isequal(mod(sizeX(1), divide), 0)
            break;
        end
        sizeX(1) = sizeX(1) - 1;
    end
    for i = sizeX(2) : -1 : 1
        if isequal(mod(sizeX(2), divide), 0)
            break;
        end
        sizeX(2) = sizeX(2) - 1;
    end
    X = wkeep(X, sizeX, 'c');
end