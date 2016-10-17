function result = f_linelength(signal)

shift = circshift(signal,[0,-1]);
result = sum(abs(signal - shift)) ./ length(signal);

end