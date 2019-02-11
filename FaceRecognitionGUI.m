function varargout = FaceRecognitionGUI(varargin)
% FACERECOGNITIONGUI MATLAB code for FaceRecognitionGUI.fig
%      FACERECOGNITIONGUI, by itself, creates a new FACERECOGNITIONGUI or raises the existing
%      singleton*.
%
%      H = FACERECOGNITIONGUI returns the handle to a new FACERECOGNITIONGUI or the handle to
%      the existing singleton*.
%
%      FACERECOGNITIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACERECOGNITIONGUI.M with the given input arguments.
%
%      FACERECOGNITIONGUI('Property','Value',...) creates a new FACERECOGNITIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FaceRecognitionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FaceRecognitionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FaceRecognitionGUI

% Last Modified by GUIDE v2.5 08-Jan-2019 19:01:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FaceRecognitionGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FaceRecognitionGUI_OutputFcn, ...
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


% --- Executes just before FaceRecognitionGUI is made visible.
function FaceRecognitionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FaceRecognitionGUI (see VARARGIN)

% Choose default command line output for FaceRecognitionGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FaceRecognitionGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FaceRecognitionGUI_OutputFcn(hObject, eventdata, handles) 
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
[filename,filepath]=uigetfile({'/Users/inder/Downloads/face_recognition_project/test images/*.jpg'}, 'Search Image To Be Displayed');
fullname = [filepath filename];
%now read the image (fullimage)
ImageFile = imread (fullname);
%let's display the image
axes(handles.axes1)
imshow(ImageFile,[]);
%Clear Image Scaling
handles.test_image = ImageFile;
guidata(hObject, handles);
axis off

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_test = handles.test_image;

[matchedImage] = facerecognition(img_test);
axes(handles.axes2)
imshow(matchedImage,[]);
axis off
