function varargout = dwt_ezw(varargin)
% DWT_EZW MATLAB code for dwt_ezw.fig
%      DWT_EZW, by itself, creates a new DWT_EZW or raises the existing
%      singleton*.
%
%      H = DWT_EZW returns the handle to a new DWT_EZW or the handle to
%      the existing singleton*.
%
%      DWT_EZW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DWT_EZW.M with the given input arguments.
%
%      DWT_EZW('Property','Value',...) creates a new DWT_EZW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dwt_ezw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dwt_ezw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dwt_ezw

% Last Modified by GUIDE v2.5 08-May-2017 19:48:49

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @dwt_ezw_OpeningFcn, ...
                       'gui_OutputFcn',  @dwt_ezw_OutputFcn, ...
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

% --- Executes just before dwt_ezw is made visible.
function dwt_ezw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dwt_ezw (see VARARGIN)

% Choose default command line output for dwt_ezw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dwt_ezw wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%��ʼ��ʱ������ʾͼƬ����������Ϊ���ɼ�
clear global;%���ȫ�ֱ���
set(handles.axes1, 'vis', 'off');
set(handles.axes2, 'vis', 'off');
set(handles.text4, 'vis', 'off');
set(handles.text5, 'vis', 'off');
set(handles.text7, 'vis', 'off');
end

% --- Outputs from this function are returned to the command line.
function varargout = dwt_ezw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- ��ͼƬ��ť.
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
    global X;

    if filename == 0%δѡ��ͼƬ
        return;
    end
    X = imread([pathname filename]);
    
    if numel(size(X))> 2
        X=rgb2gray(X);%����ǲ�ɫ��ת�ɻҶ�ͼ
    end
    
    global fileSizeIn;
    %��ʾԭͼ��С
    d = dir([pathname filename]);
    fileSizeIn = d.bytes / 1024;
    set(handles.text4, 'vis', 'on');
    set(handles.text4, 'String', [sprintf('%.2f', fileSizeIn) 'KB']);
    
    axes(handles.axes1);%����Ƕ�λ����Ӧ��������
    imshow(X);
    title('ԭͼ');
end


% --- ѹ����ť.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global X;
    if  isempty(X)
        msgbox('����ѡ��ͼƬ');
        return;
    end
    
    global dim;%�任����%�������ȫ��
    dim = get(handles.popupmenu1, 'value');
    [rowX, colX] = size(X);
    if log2(rowX) ~= fix(log2(rowX)) || log2(colX) ~= fix(log2(colX))
        msgbox('ͼƬ��ʽ���ԣ�����������ֵ����Ϊ2��ָ���η�');
        return;
    end
    maxDim = min(log2(rowX), log2(colX))
    if dim > maxDim
        msgbox(['��ͼ��ֽ⼶�����Ϊ' num2str(maxDim) '��������ѡ��']);
        return ;
    end
    
    scanTimes = get(handles.popupmenu2, 'value');
    global s;%����ʱ�����ʾ�õ�
    [c, s] = wavedec2(X, dim, 'db1');
    %��ȡ�����ĵ�Ƶϵ��
    cai =  appcoef2(c, s, 'db1', dim);
    cAll = c2mat(cai, c, s, dim);
    
    global row col;%�������ȫ��
    [row, col] = size(cAll);
    %��ȡ��ֵ
    maxDecIm = max(max(abs(cAll)));
    T = zeros(1, scanTimes);
    T(1) = 2 ^ floor(log2(maxDecIm));
    %���������ֵ
    for i = 2 : scanTimes
        T(i) = T(i - 1) / 2;
    end
    %����
    [scanCodes, quantiFlags, perScanNums] = ezwEncode(cAll, T, scanTimes, handles);
    fileSizeOut = getEncodedSize(perScanNums, scanTimes);
    
    %����
    cAllDecode = ezwDecode(T(1), scanTimes, scanCodes, perScanNums(:, 1)', quantiFlags, perScanNums(:, 2)', handles);
   
    %����ļ���С--��ʾ��text5
    set(handles.text5, 'vis', 'on');
    set(handles.text5, 'String', [sprintf('%.2f', fileSizeOut) 'KB']);
    
    %ѹ����,psnr,ssim��ʾģ��---��ʾ��text7��%
    global Y;
    psnrV = psnr(X, Y);
    ssimV = ssim(X, Y);
    global fileSizeIn;
    text7content = ['ѹ���ȣ�' sprintf('%.2f', fileSizeIn / fileSizeOut) [' : 1']]
    text7content = [text7content char(13,10)' 'PSNR��' sprintf('%.2f', psnrV) ['dB']];
    text7content = [text7content char(13,10)' 'SSIM��' sprintf('%.2f', ssimV)];
    set(handles.text7, 'vis', 'on');
    set(handles.text7, 'string', text7content);
    
    set(handles.text6, 'string', ['�����������']);
end

% ---ѡ����
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
