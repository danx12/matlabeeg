function result = f_ARCoeff(signal,order,method)

adjSignal = signal - mean(signal);

% error = [];
switch method,
    case 'burg',
        error = arburg(adjSignal, order);

    case 'cov',
        error = arcov(adjSignal, order);

    case 'mcov',
        error = armcov(adjSignal, order);

    case 'yule',
        error = aryule(adjSignal, order);

    case 'lpc',
        error = lpc(adjSignal, order);
        
    otherwise,
        return;
end

error = adjSignal - filter(error,1,adjSignal);
result = sqrt(sum(error .^ 2) / length(error));

end