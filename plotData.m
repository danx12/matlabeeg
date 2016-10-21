function plotData(data,sampFreq,rowOfEvents,chan)

% Assumes there is only one event per file.
    dims = size(data);

    time = linspace(0,dims(2)/sampFreq,dims(2));

    idxEvents = find(data(rowOfEvents,:)');
    if isempty(idxEvents)
        clf;
        plot(time(:),data(chan,:),'b');
        return;
    end
    minIdx = min(idxEvents);
    maxIdx = max(idxEvents);

    clf;
    hold all;
    plot(time(1:minIdx-1),data(chan,1:minIdx-1));
    plot(time(minIdx:maxIdx),data(chan,minIdx:maxIdx),'r');
    plot(time(maxIdx+1:end),data(chan,maxIdx+1:end),'g');
    
end
