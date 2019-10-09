function varargout = main_gui(varargin)
% MAIN_GUI MATLAB code for main_gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_gui

% Last Modified by GUIDE v2.5 29-Dec-2018 17:29:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @main_gui_OutputFcn, ...
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


% --- Executes just before main_gui is made visible.
function main_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_gui (see VARARGIN)

% Choose default command line output for main_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.读取一张待识别的图片
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global str img cc
[filename,pathname] = uigetfile({'*.jpg';'*.bmp'},'选择图片');
str = [pathname,filename];
img = imread(str);
cc=imread(str);
subplot(1,3,1),imshow(cc);
set(handles.text5,'string',str);


% --- Executes on button press in pushbutton3.关闭图形界面
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);




% --- Executes on button press in pushbutton4.表情识别
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cc img t
load('save.mat');
 mapping=getmapping(8,'u2');%LBP映射
        W=[2,1,1,1,1,1,2; ...
          2,4,4,1,4,4,2; ...
          1,1,1,0,1,1,1; ...
          0,1,1,0,1,1,0; ...
          0,1,1,1,1,1,0; ...
          0,1,1,2,1,1,0; ...
          0,1,1,1,1,1,0]; 
d=[];
 image_size = size(cc);
   dimension = numel(image_size);
   if dimension == 3
      cc=rgb2gray(cc);
   end
   
       X = double(cc);
      X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为64*64
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  d=[d;a];

P_test=d;
P_test=mapminmax(P_test,0,1);
%%%%%%%%以上是特征提取的部分


%%%%%从这里开始是识别表情的算法，使用支持向量机来识别
addpath SVM-KM  %%添加支持向量机工具箱
c = 100;

kerneloption= 1.3;   %设置核参数
kernel='gaussian'; %设置高斯核作为支持向量机的核函数
[ypred2,maxi] = svmmultival(P_test,xsup,w,b,nbsv,kernel,kerneloption);

   for i=1:length(ypred2)
    if ypred2(i)==1  disp('Anger');t='Anger';
    elseif ypred2(i)==2     t='Disgust';   
    elseif ypred2(i)==3     t='Fear';  
    elseif ypred2(i)==4    t='Happiness';
    elseif ypred2(i)==5    t='Sad';
    elseif ypred2(i)==6    t='Surprise';
    end
    detector = vision.CascadeObjectDetector;
    bboxes=step(detector,img);
    FrontalFaceCART=insertObjectAnnotation(img,'rectangle',bboxes,t,'color','cyan','TextBoxOpacity',0.8,'FontSize',13);
    subplot(1,3,2),imshow(FrontalFaceCART);
   end
    set(handles.text10,'string',t);

% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load('save.mat');
disp('训练结束');
axes(handles.axes2);
vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid, hImage);
disp('摄像头开启');
faceDetector1 = vision.CascadeObjectDetector;
while(1)
frame = getsnapshot(vid);
box = step(faceDetector1, frame); % Detect faces
if isempty(box)==0
    ff=imcrop(frame,[box(1),box(2),box(3),box(4)]);
%figure;imshow(cc);
    ff=rgb2gray(ff);
%figure;imshow(cc);
    ff=histeq(ff);       %直方图均衡化
%     imwrite(cc,'.\test\1.jpg');
    yy=svm_test(xsup,w,b,nbsv,ff);
    h=rectangle('position',[box(1),box(2),box(3),box(4)],'LineWidth',2,'edgecolor','b');
    for i=1:length(yy)
        if yy(i)==1      t1=text(box(1),box(2)-20, sprintf('生气'),'FontSize',14,'Color','blue','FontWeight','Bold');
        elseif yy(i)==2     t1=text(box(1),box(2)-20, sprintf('厌恶'),'FontSize',14,'Color','blue','FontWeight','Bold');
        elseif yy(i)==3       t1=text(box(1),box(2)-20, sprintf('恐惧'), 'FontSize',14,'Color','blue','FontWeight','Bold');      
        elseif yy(i)==4       t1=text(box(1),box(2)-20, sprintf('高兴 '), 'FontSize',14,'Color','blue','FontWeight','Bold'); 
        elseif yy(i)==5       t1=text(box(1),box(2)-20, sprintf('悲伤'), 'FontSize',14,'Color','blue','FontWeight','Bold');      
        elseif yy(i)==6       t1=text(box(1),box(2)-20, sprintf('惊讶'), 'FontSize',14,'Color','blue','FontWeight','Bold');
        end
    end
      pause(0.05);
      set(t1,'string',[]);
      delete(h);
        if strcmpi(get(gcf,'CurrentCharacter'),'c')
         delete(vid);
         disp('程序退出');
         break;
        end

      
else t1=text(10,10, sprintf('未检测到人脸'), 'FontAngle','italic','FontSize',15,'Color','b','FontWeight','Bold');
     pause(0.05);
     set(t1,'string',[]);
     if strcmpi(get(gcf,'CurrentCharacter'),'1')
         delete(vid);
         disp('程序退出');
         break;
     end
end
end
