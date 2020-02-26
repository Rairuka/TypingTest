function PlotStats(handles.numTries,handles.wpmList);  
%function that plots num tries and wpm will be used in gui but with handles
%this is a test run

%plot with own labels
figure('Name','Words per minute against Number of tries');
plot(numTries,wpm)
xlabel('Try x')
ylabel('Your word per minute')
title('Words per minute against Number of tries')

