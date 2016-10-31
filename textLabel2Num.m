function numLabels = textLabel2Num(labels)
    dims = size(labels);
    numLabels = zeros(dims(1),1);
    for i=1:dims(1)
       if strcmp(labels(i),'seizure')
           numLabels(i) = 1;
       end
    end

    return;


end