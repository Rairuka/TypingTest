%making a script that generates random words
wordTxt=fileread('words.txt');
words=splitlines(wordTxt);
words2=words %userInput is compared to this



%for loop
%while handles.tStat~=0
%while ~handles.tStat~=3
%for i=1:length(words)
%if userInput(i)== strGen(i)
%corWords=[corWords strGen(i)]
%else
%wroWords=[wroWords strGen(i)]
%end
%end
%end
%end
