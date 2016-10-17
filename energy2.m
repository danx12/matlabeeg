function result = energy2(signal)

result = sum(signal .^ 2) / size(signal,2);

end
