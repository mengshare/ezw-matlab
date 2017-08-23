function varargout = dwt_jpg(varargin)
% DWT_JPG MATLAB code for dwt_jpg.fig
%      DWT_JPG, by itself, creates a new DWT_JPG or raises the existing
%      singleton*.
%
%      H = DWT_JPG returns the handle to a new DWT_JPG or the handle to
%      the existing singleton*.
%
%      DWT_JPG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DWT_JPG.M with the given input arguments.
%
%      DWT_JPG('Property','Value',...) creates a new DWT_JPG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dwt_jpg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dwt_jpg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dwt_jpg

% Last Modified by GUIDE v2.5 17-Apr-2017 16:56:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dwt_jpg_OpeningFcn, ...
                   'gui_OutputFcn',  @dwt_jpg_OutputFcn, ...
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

% --- Executes just before dwt_jpg is made visible.
function dwt_jpg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dwt_jpg (see VARARGIN)

% Choose default command line output for dwt_jpg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dwt_jpg wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clear global;%���ȫ�ֱ���
%��ʼ��ʱ������ʾͼƬ����������Ϊ���ɼ�
set(handles.axes1, 'vis', 'off');
set(handles.axes2, 'vis', 'off');
%ѹ�����������
set(handles.listbox1, 'vis', 'off');
set(handles.slider1, 'vis', 'off');
%text
set(handles.text2, 'vis', 'off');
set(handles.text3, 'vis', 'off');
set(handles.text4, 'vis', 'off');
set(handles.text5, 'vis', 'off');
%���水ť
set(handles.pushbutton2, 'vis', 'off');
end

% --- Outputs from this function are returned to the command line.
function varargout = dwt_jpg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

%{
% --- Executes on button press in pushbutton1.
ѡ��ť
ѡ��Ҫѹ����ͼƬ����ʾ
%}
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
    [fileName, pathName, filterindex] = uigetfile(filter, 'ѡ��ͼƬ');

    %���δѡ��ͼƬ���жϣ���������ж�ʱ���δѡ��ͼƬ����ִ����ȥ�ᱨ��
    if isequal(fileName, 0) | isequal(pathName, 0)
        return
    end

    %��ȡͼƬ����ʾ
    global X;
    X = imread([pathName fileName]);
    axes(handles.axes1);%����Ƕ�λ����Ӧ��������
    imshow(X);
    title('ԭͼ');

    %��ȡͼƬ��ʵ��С
    fileId = fopen([pathName fileName]);
    fseek(fileId,0,'eof');
    fileSizeIn = ftell(fileId)/1024;
    fileSizeIn =round(fileSizeIn);%ȡ��
    set(handles.text4, 'String', [num2str(fileSizeIn) 'KB']);
    
    show(1, 0.5, handles);
    set(handles.listbox1, 'value', 2);%Ĭ��4:1
    set(handles.slider1, 'value', 0.5);%Ĭ��0.5
    
    %ѹ�������������ʾ
    set(handles.listbox1, 'vis', 'on');
    set(handles.slider1, 'vis', 'on');
    %text
    set(handles.text2, 'vis', 'on');
    set(handles.text3, 'vis', 'on');
    set(handles.text4, 'vis', 'on');
    set(handles.text5, 'vis', 'on');
    %���水ť
set(handles.pushbutton2, 'vis', 'on');
end

function show(dim, lightWeight, handles)
    global X;
     if  isempty(X)
        msgbox('����ѡ��ͼƬ');
        return;
    end
    %dwt�任����ʱֻ������ֽ�%
    waveBase = 'db1';
    [c, s] = wavedec2(X, dim, waveBase);
    %ȡ�����ĵ�Ƶ/���� ϵ����
    cai = appcoef2(c, s, waveBase, dim);
    axes(handles.axes2);
    global Y;
    Y = uint8(cai * lightWeight);
    imshow(Y);
    title('ѹ�����ͼƬ');
    
    %��ȡ���ͼ���С
    filename = 'tmp.jpg';
    imwrite(Y, filename);
    fileId = fopen(filename);
    fseek(fileId,0,'eof');
    fileSizeOut = ftell(fileId)/1024;
    fileSizeOut =round(fileSizeOut);%ȡ��
    set(handles.text5, 'String', [num2str(fileSizeOut) 'KB']);
    %delete(filename);
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
    global CompressRate;
    CompressRate = get(handles.listbox1, 'value');
    if CompressRate == 1
        msgbox('��ѡ��ѹ����');
        return;
    end
    dim = CompressRate -1;
    lightWeight = 0.5 ^ dim;
    show(dim, lightWeight, handles);
    %���ù�����Ĭ��ֵ
    set(handles.slider1, 'value', lightWeight);
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    global CompressRate;
    CompressRate = get(handles.listbox1, 'value');
    dim = CompressRate -1;
    global lightWeight;
    lightWeight = get(handles.slider1, 'value');
    show(dim, lightWeight, handles);
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
end


% --- ���水ť
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %��ʱֻ֧�ֱ����jpg��ʽ
    filter = { '*.jpg', 'JPEG�ļ� (*.jpg)'; };
    [filename, pathname] = uiputfile(filter, 'Save Picture', 'D:\matlab\output\unTitled.jpg');
    if isequal(filename,0) | isequal(pathname,0)
        return
    end
    global Y;
    imwrite(Y, [pathname, filename]);
    msgbox('����ɹ�');
end
