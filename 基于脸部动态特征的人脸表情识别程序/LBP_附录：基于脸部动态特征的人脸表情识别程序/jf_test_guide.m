function varargout = jf_test_guide(varargin)
%JF_TEST_GUIDE MATLAB code file for jf_test_guide.fig
%      JF_TEST_GUIDE, by itself, creates a new JF_TEST_GUIDE or raises the existing
%      singleton*.
%
%      H = JF_TEST_GUIDE returns the handle to a new JF_TEST_GUIDE or the handle to
%      the existing singleton*.
%
%      JF_TEST_GUIDE('Property','Value',...) creates a new JF_TEST_GUIDE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to jf_test_guide_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      JF_TEST_GUIDE('CALLBACK') and JF_TEST_GUIDE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in JF_TEST_GUIDE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jf_test_guide

% Last Modified by GUIDE v2.5 08-Oct-2019 14:41:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jf_test_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @jf_test_guide_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before jf_test_guide is made visible.
function jf_test_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for jf_test_guide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jf_test_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jf_test_guide_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
