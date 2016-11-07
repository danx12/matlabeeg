function plotDataAllChan(data,sampFreq,rowOfEvents,numOfChan)
   vname = @(x) inputname(1);
% Assumes there is only one event per file.
    dims = size(data);

    time = linspace(0,dims(2)/sampFreq,dims(2));

    idxEvents = find(data(rowOfEvents,:)');
    clf;
    title(vname(data));
    if isempty(idxEvents)
            for i=1:numOfChan
                subplot(3,1,i);
                hold on;

                plot(time(:),data(numOfChan,:),'b');
                hold off;
            end
        
        return;
    end
    minIdx = min(idxEvents);
    maxIdx = max(idxEvents);

    
%     figure;
%     subplot(4,1,1)
    for i=1:numOfChan
        subplot(3,1,i);
%         figure;
        hold on;
       
        plot(time(1:minIdx-1),data(i,1:minIdx-1));
        plot(time(minIdx:maxIdx),data(i,minIdx:maxIdx),'r');
        plot(time(maxIdx+1:end),data(i,maxIdx+1:end),'g');
        hold off;
 
    end
    
   
    
end
