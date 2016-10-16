% This section of the code calculates the energy of the signals in order to
% find possilbe seizure zones. It finds them by searching for areas with
% high energy in the EEG signals. If enough of the EEG channels have high
% energy in the same place, that location is marked as a possible seizure
% zone

%  1 - 64 are grid  EEGs
% 75 - 95 are scalp EEGs
for i = 75:95%1:64  % loop through the given channels of the EEG
    time_divisions = 2; % divide signal up into 2 second blocks for energy calculation
    [e(:,i),te] = energy(lowsignal(:,i),time_divisions,Fs);
    
    
    %% 
    % We now have a plot of the energy of the signal. We will now search
    % through the data to find peaks in the energy plot. The threshold used
    % to mark seizures is 7 times the standard deviation of the energy
    % plot.
    if i == 1 || i == 75 % needed on the first pass of the loop in order to initialize the points structure
        points.amount = zeros(1,length(e(:,i)));
        points.channel = zeros(64,length(e(:,i)));
    end

    stdev = std(e(:,i)); % find the standard deviation of the energy signal
    possibilities = find(e(:,i) > stdev*7); % use standard deviation to threshold the signal for possible seizure zones
    points.amount(possibilities) = points.amount(possibilities) + 1; % count the number of possible seizure zones
    points.channel(i,possibilities) = 1; % mark that the location of a possible seizure for each channel
end

points.index = find(points.amount > 8); % if more than 8 channels share the same possible seizure zone, mark that area as a possible seizure
points.index * time_divisions % display time locations in the signal of possible seizures
points.amount(points.index)% display number of channels the seizure was detected on