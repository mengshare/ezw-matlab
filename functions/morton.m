 %{
��ȡָ�������scanList
@param Mat ϵ������
@return scanList 
%}
  function scanList = morton(Mat)
    global row col   
    matlist = mat2list(Mat);   
    scanorder = listOrder(row,col,1,1);  
    scanList = [];  
    %{
    %10�������������������������10����ر���
    
    for i = 1 : row * col       
        scanList = [scanList; i scanorder(i,:) matlist(i)];  
    end
    %}
    %10�������������
    id = [1 : row * col];
    id = id';
    scanList = [id scanorder matlist];
    
  end 
  