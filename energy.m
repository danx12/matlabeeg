function [ e , te ] = energy( signal , div , Fs )
% this function is designed to calculate the energy of a given signal using
% the time division provided by div
% it returns the energy values for each time block and an array for the
% times for easier plotting

divisions = div*Fs;

sec = floor(length(signal)/divisions);

for k = 1:sec-1
    
    e(k) = 0;
    
    for i = 0:divisions-1
        e(k) = e(k) + signal(i+k*divisions)^2;
        
    end
    %e(k) = sqrt(e(k));
end
te = 4+div*2:div:1200;
end