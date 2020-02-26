%making a 60 second count down
t = timer
t.Period=1
t.StartDelay=4
t.TimerFcn = @(myTimerObj, thisEvent)disp('60 seconds  have elasped')
start(t)
pause(t.StartDelay)
disp('x')



