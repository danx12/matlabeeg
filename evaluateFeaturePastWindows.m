function [featureData,execTime] = evaluateFeaturePastWindows(func,data,varargin)
%%Computes the feature data and execution time of one row (one window) 
%%for a given feature function, data and a variable number of arguments.

dataDims = size(data);
featureData = zeros(dataDims(1),1);


for i = 1:dataDims(1)
    featureData(i,:) = func(data(i,:),varargin{:});
end

f = @() func(data(1,:),varargin{:});

execTime = timeit(f);


end