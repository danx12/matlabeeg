function plotFeature(feature,labels)
    
    tdims = size(feature);
    
    if(tdims(1) > tdims(2))
        feature = feature';
    end
    
    tdims = size(labels);
    
    if(tdims(1) > tdims(2))
        labels = labels';
    end


    dims = size(feature);

    time = linspace(0,dims(2),dims(2));

    idxEvents = find(labels);
    if isempty(idxEvents)
        clf;
        plot(time(:),feature,'y');
        return;
    end
   

    clf;
    hold all;
    
    idx = 0;
    for i=1:length(idxEvents)
        endIndex = idx;
       while(endIndex ~= idxEvents(i))
           endIndex = endIndex + 1;
       end
       plot(time(idx:endIndex),feature(idx:endIndex));
       
       while(endIndex == 
       
        
    end
    
    
    plot(time(1:minIdx-1),feature(1:minIdx-1));
    plot(time(minIdx:maxIdx),feature(minIdx:maxIdx),'r');
    plot(time(maxIdx+1:end),feature(maxIdx+1:end),'g');
    
end
