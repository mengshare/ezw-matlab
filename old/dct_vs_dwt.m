%{
%��ɢ���ұ任��DCT����С���任��DWT�������ܱȽ�
%��ͼ��ֱ𾭹����ֱ任�󣬱������ɵĵ�Ƶϵ����1/4������3/4��0��
%�ٽ�����Ӧ����任�ָ�ͼ�񣬱Ƚϵ�Ƶϵ��1/4������ռ�������ı�����
%�Լ���������ĺ�ͼ����ԭͼ�ķ�ֵ����ȣ�PSNR�����ṹ������(SSIM)
%}
function varargout = dct_vs_dwt(varargin)
% DCT_VS_DWT MATLAB code for dct_vs_dwt.fig
%      DCT_VS_DWT, by itself, creates a new DCT_VS_DWT or raises the existing
%      singleton*.
%
%      H = DCT_VS_DWT returns the handle to a new DCT_VS_DWT or the handle to
%      the existing singleton*.
%
%      DCT_VS_DWT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCT_VS_DWT.M with the given input arguments.
%
%      DCT_VS_DWT('Property','Value',...) creates a new DCT_VS_DWT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dct_vs_dwt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dct_vs_dwt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dct_vs_dwt

% Last Modified by GUIDE v2.5 22-Jan-2017 14:45:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dct_vs_dwt_OpeningFcn, ...
                   'gui_OutputFcn',  @dct_vs_dwt_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before dct_vs_dwt is made visible.
function dct_vs_dwt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dct_vs_dwt (see VARARGIN)

% Choose default command line output for dct_vs_dwt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dct_vs_dwt wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%��ʼ��ʱ������ʾͼƬ��������������Ϊ���ɼ�
set(handles.axes1, 'vis', 'off');
set(handles.axes2, 'vis', 'off');
set(handles.axes3, 'vis', 'off');

%�����Ϊ���ɼ�
set(handles.uitable1, 'vis', 'off');

end

% --- Outputs from this function are returned to the command line.
function varargout = dct_vs_dwt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% ����ͼ�񡱰�ť�Ļص�����
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ͼ���ļ����͹���
filter = { ...
        '*.bmp; *.jpg; *.gif; *.png; *.tif', '����ͼ���ļ� (*.bmp; *.jpg; *.gif; *.png; *.tif)'; ...
        '*.bmp',  'λͼ�ļ� (*.bmp)'; ...
        '*.jpg', 'JPEG�ļ� (*.jpg)'; ...
        '*.gif', 'GIF�ļ� (*.gif)'; ...
        '*.png', 'ͼԪ�ļ� (*.png)'; ...
        '*.*',  '�����ļ� (*.*)' ...
};

%����ѡ��ͼƬ�ļ��ĶԻ���
[filename, pathname, filterindex] = uigetfile(filter, 'ѡ��ͼƬ');

%���δѡ��ͼƬ���жϣ���������ж�ʱ���δѡ��ͼƬ����ִ����ȥ�ᱨ��
if isequal(filename,0) | isequal(pathname,0)
    return
end

%��ȡͼƬ����ʾ
X = imread([pathname filename]);
if numel(size(X))> 2
    X=rgb2gray(X);%����ǲ�ɫ��ת�ɻҶ�ͼ
end
axes(handles.axes1);%����Ƕ�λ����Ӧ��������
imshow(X);
title('ԭͼ');

sizeX = size(X);
sizeTarget = size(X);
%ȡԭͼ�������ķ�һ
switch nnz(sizeTarget)
    case 2
        sizeTarget = sizeTarget .* [0.5 0.5];
    case 3
        sizeTarget = sizeTarget .* [0.5 0.5 1];
    otherwise
        %����
end
%ע�����ﲻ����uint8����Χ̫С
uint16(sizeTarget);


%dct�任ͳһ����汾%
cDct = dct2(X);
cDctBak = cDct;
%��ֱ��б�߲�����0
%           ��������/2   + 1 �����һ�� ��1�У����һ��
cDct((sizeTarget(1, 1) + 1) : sizeX(1, 1), 1 : sizeX(1, 2)) = 0;
%ˮƽ������0
%     1 : ��������/2��    ,          ��������/2+1   :���һ��
cDct(1 : sizeTarget(1, 1), (sizeTarget(1, 2) + 1) : sizeX(1, 2)) = 0;
Dct = idct2(cDct, sizeX);
Dct = uint8(Dct);
axes(handles.axes2);
imshow(Dct);
title('dct�任��ԭ');

%��������
e1 = sum(sum(abs(cDct)));
e2 = sum(sum(abs(cDctBak)));
%tableData���������fig�ļ�
tableData = zeros(3, 2);
tableData(1, 1) = e1 / e2 * 100;
tableData(2, 1) = psnr(Dct, X);
[ssimval, ssimmap] = ssim(Dct, X);
tableData(3, 1) = ssimval * 100;
%dct�任����%

%{
%dct�任8*8�ֿ鴦��汾%
fun1=@dct2;
cDct=blkproc(X, [8 8], fun1);
cDctBak = cDct;
T = zeros(8, 8);
T(1 : 4, 1 : 4) = 1;
cDct=blkproc(cDct, [8 8],'P1.*x',T);
fun2=@idct2;
Dct = blkproc(cDct, [8 8], fun2);
Dct = uint8(Dct);
axes(handles.axes2);
imshow(Dct);
title('dct�任��ԭ');

%��������
e1 = sum(sum(abs(cDct)));
e2 = sum(sum(abs(cDctBak)));
%tableData���������fig�ļ�
tableData = zeros(3, 2);
tableData(1, 1) = e1 / e2 * 100;
tableData(2, 1) = psnr(Dct, X);
[ssimval, ssimmap] = ssim(Dct, X);
tableData(3, 1) = ssimval * 100;
%dct�任����%
%}
%dwt�任%
waveBase = 'db10';
[cDwt, sDwt] = wavedec2(X, 1, waveBase);
cDwtBak = cDwt;
%��cDwt����1/4�����ȫ���0
cDwt((sDwt(1,1) * sDwt(1,2) + 1) : length(cDwt)) = 0;
%��任����ʾͼ��
Dwt = waverec2(cDwt, sDwt, waveBase);
Dwt = uint8(Dwt);
axes(handles.axes3);
imshow(Dwt);
title('С���任��ԭ');

e1 = sum(abs(cDwt));
e2 = sum(abs(cDwtBak));
tableData(1, 2) = e1 / e2 * 100;
tableData(2, 2) = psnr(Dwt, X);
[ssimval, ssimmap] = ssim(Dwt, X);
tableData(3, 2) = ssimval * 100;
%dwt�任����%

%��������Ϣ����table�в���ʾ���
set(handles.uitable1, 'data', tableData);
set(handles.uitable1, 'vis', 'on');

end
