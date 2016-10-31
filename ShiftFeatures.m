
%Shift the features by one.

indexOfFeatures = [1,2,3,59,60,61,62,63];


[rows,cols] = size(eegTrainActivity);

historyFeatures = zeros(rows,length(indexOfFeatures));

for idxFeatures=1:length(indexOfFeatures)
    for idxWindows=2:rows-1
        historyFeatures(idxWindows,idxFeatures) = eegTrainActivity{idxWindows,idxFeatures};
        
    end
    
end