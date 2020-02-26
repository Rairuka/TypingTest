function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 15-Sep-2019 19:36:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ... 
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Handles workspace for using with other functions later on


%words for word gen
%reading words.txt
handles.wordTxt = fileread('words.txt');

%converting to cell array,separated
handles.words = splitlines(handles.wordTxt);

%variable that is assigned a random word from handle.words using  rand
%from 1-the length of handle.words (roughly 10000 ish), 
%ceil and length(handles.words)-1 help to avoid negative indices and going
%over max index of handle.words
handles.randWord = handles.words(ceil(rand()*length(handles.words)-1))


%empty vectors for correct and wrong words
handles.corWords = []
handles.wroWords = []


%count for number of elems in correct Words and wrong Words
handles.numCor = 0
handles.numWro = 0


%Handles for number of tries and word per minute and wpm list
handles.numTries = 0
handles.wpmList = []


%handles.wpm is a variable that will be called upon for wpm calculation
%later
handles.wpm = (handles.numCor)-(handles.numWro)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%user input box


function edit1_Callback(hObject, eventdata, handles)
%function that creates an edit box so the user can enter in strings


% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%testing with input

%get(hObject, 'String') gets current string in edit box and assign it to
%handles.val
handles.val = get(hObject, 'String')


%if user input handles.val is equal to the random word generated
if string(handles.val) == string(handles.randWord)
    
    %concatenate into corWords 
    handles.corWords = [handles.corWords string(handles.val)]
    
    %generate new randWord 
    handles.randWord = handles.words(ceil(rand()*length(handles.words)-1))
    
    %set the static text for display generated word
    set(handles.text7,'String',string(handles.randWord))
    
    %set editbox to be empty so user doesn't need to backspace current word
    set(handles.edit1,'String','')
    
    %adds 1 to the count of correct words
    handles.numCor = handles.numCor+1

    %for when the word input by user doesn't match generated word
else
    %concatenate into wroWords 
    handles.wroWords = [handles.wroWords string(handles.val)]
    
    %generate new randWord 
    handles.randWord = handles.words(ceil(rand()*length(handles.words)-1))
    
    %set the static text for display generated word
    set(handles.text7,'String',string(handles.randWord))
    
    %set editbox to be empty so user doesn't need to backspace current word
    set(handles.edit1,'String','')
    
    %adds 1 to the count of wrong words
    handles.numWro = handles.numWro+1
end

%guidata used to save handles so the values can be used with other
%functions
guidata(hObject, handles)




% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
    'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Start button


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%function that programs the start button


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%adding an attempt to attempt counter
handles.numTries = handles.numTries+1

%showing attempt no. to gui
set(handles.text9,'String',handles.numTries)

%setting the first generated word
set(handles.text7,'String',string(handles.randWord))

%setting current wpm displayed to unknown
set(handles.text8,'String','?')

%setting running status for timer panel
set(handles.text6, 'String' , 'Running');

%turn on userinput box so user can start typing
set(handles.edit1,'enable','on')

%setting inputBox (edit1) to empty for user to start typing
set(handles.edit1,'String','')

%setting corWords and wroWords to empty for new start
handles.corWords = []
handles.wroWords = []

%count for number of elems in corWords and wroWords
handles.numCor = 0
handles.numWro = 0


%executing timer script that changes status to finished and turns off edit
%so user can't type further

%timer 1 that goes up by 1 second. Start delay is 60 seconds so we can have
%a minute.
t = timer
%updating each second
t.Period = 1
t.StartDelay = 60
%changes status of timer panel value to finished
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.text6,'String','Finished')
%turns off edit box
t.StopFcn = @(myTimerObj, thisEvent)set(handles.edit1,'enable','off')

%deleting timer created(not too sure but matlab doc web recommends we do
%this
t2 = timer
%updating each second
t2.Period = 1
%set timer for 60 seconds
t2.StartDelay = 60
%delete(timerfind) deletes all create timers
t2.TimerFcn = @(myTimerObj, thisEvent)delete(timerfind)

%starting timers
start(t)%starting timer 
start(t2)%deleting timer

guidata(hObject, handles)



%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%running commands and deleting once timer is finished
%pause(t.StartDelay) %pausing for length of timer delay
%delete(timerfind) %deleting timer afterwards otherwise it'll cause future 
%problems


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%ploting button
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
%creates a plot button on gui

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%create new figure window
figure


%plotting num of tries against record wpm's
%maker is +, size is 20
%colour is red
plot(1:1:handles.numTries,handles.wpmList,':+','Color',[1,0,0],...
    'MarkerSize',20)


%setting labels
title('WPM vs Attempt')
xlabel('Attempt')
ylabel('Your WPM')


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Quit button


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
%function creates a quit button

%function that quits the application with a pause so it seems not as fast
pause(0.5)

%close all force closes everything down
close all force


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Timer status text

% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
%creates timer status text


% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text6.
function text6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%background image for gui


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
%creates axis which we will use to display an image

% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%show backgrond image in directory of interface
imshow('bgimage.jpg')


% Hint: place code in OpeningFcn to populate axes1

%userInput box on pressing enter, run callback for userInput box
% --- Executes on key press with focus on edit1 and none of its controls.


function edit1_KeyPressFcn(hObject, eventdata, handles)
%function that records the string entered by user and calls on the call
%back of the edit text box when user presses enter

% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



%on key press enter, record correct word
%code that compares keypress with return, if they match, execute
%edit1_Callback
    if (strcmp(eventdata.Key, 'return')) 
        edit1_Callback(hObject, eventdata, handles)
    end
    
    
 guidata(hObject, handles)


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%wpm display


% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(hObject, eventdata, handles)
%function that creates text for the wpm display

% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%reset button


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
%call back code for the reset button

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%sets number of tries to 0 and makes wpmList an empty vector
handles.numTries = 0
handles.wpmList = []


guidata(hObject,handles)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%calculate wpm button


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
%function that calculatesm,displays and records wpm into the wpmList

% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%variable that calculates wpm
handles.wpm = handles.numCor-handles.numWro

if handles.wpm>0
%concatenation of wpm to the wpmList
handles.wpmList = [handles.wpmList handles.wpm]

%sets the static text 8 to the current value of wpm calculated
set(handles.text8,'String',handles.wpm)
else
%display error on wpm status
    set(handles.text8,'String','error')
end
guidata(hObject,handles)
