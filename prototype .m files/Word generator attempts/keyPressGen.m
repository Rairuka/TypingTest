%vector file with the empty vectors i plan to use in main gui

%for plots
wpm=[]
numTries=[]

%for word gen
wordTxt=fileread('words.txt');
words=splitlines(wordTxt);
words2=words; %userInput is compared to this

%testing with input
for i = 1:length(words);
    pause
    key=get(gcf,'CurrentKey')
    if (strcmp(key, 'return'))
        disp(words(i));
        continue
    end
end



%used for conditional with word gen and user input
%correct words
corWords=[]

%wrong words
wroWords=[]