function[wpm] = wpmCalc(corWords,wroWords)
%this function will calculate the nnet words per minute

%finding number of correct words
numCorWords=length(corWords);
numWroWords=length(wroWords);

%calculation of words per minute
wpm=numCorWords-(numWroWords)

end
