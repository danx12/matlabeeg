%Convert text label to that compatible with neural network training.

tableSize = size(eegTrainActivity.labelForWindow);
labels = zeros(2,tableSize(1));
textLabel = eegTrainActivity.labelForWindow;

for i =1:tableSize(1)
    if(strcmp(textLabel(i),'normal')) 
        labels(1,i) = 1;
    else
        labels(2,i) = 1;
    end
end