%{
��ȡָ����������б��Լ���Ӧֵ��������Ƕ���һ������treeMat�ķ�װ
@param Mat ϵ������
@param chRows int ���� 
@param chRows int ����
@return chMat ���� n��3�� ��ʽ��:[r1 c1 v1; r2 c2 v2; r3 c3 v3...]
%}
 function chMat = childMat(Mat, chRows, chCols)
     chPoint = treeMat(chRows, chCols); 
     chMat = [];  
     [mRows, mCols] = size(chPoint);  
     for iRows = 1 : mRows     
         chMat = [chMat ; chPoint(iRows, 1), chPoint(iRows, 2), Mat(chPoint(iRows, 1), chPoint(iRows, 2))]; 
     end
 end
 