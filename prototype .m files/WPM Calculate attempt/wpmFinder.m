function wpmFinder(hObject,eventdata,handles,corWords,wroWords)
%this function will calculate the nnet words per minute

%finding number of correct words
numCorWords=length(corWords);
numWroWords=length(wroWords);

%calculation of words per minute
handles.wpm=numCorWords-(numWroWords)
set(handles.text8,'String',handles.wpm)

