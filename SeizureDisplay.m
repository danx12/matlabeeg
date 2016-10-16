close all

% Now that we have our seizures marked, we will display the suspected
% seizure zones in order to see the areas the algorithm has marked.
i = points.index(1); % this gives us the location of the first marked seizure

while(i <= points.index(end)) % loop through all the marked seizures to display them all
    % 80 second window to see the seizure
    window_start = (i-14)*time_divisions*Fs - 4*Fs;
    if window_start < 1 % if negative or 0 index, set window_start to 1
        window_start = 1;
    end
    window_end = (i+25)*time_divisions*Fs - 4*Fs;
    if window_end > length(lowsignal) % if index greater than length of signal, set to last position of signal
        window_end = length(lowsignal);
    end
    
    chan = find(points.channel(:,i)); % find which EEG channels were marked with possible seizures
    
    % ************************
    pos = chan(50) % choose which marked seizure you wish to display
    % ************************
    
    start_time = cut/Fs; % for seconds | divide by 60 for minutes
    end_time = 20*60; % for seconds | divide by 60 for minutes
    t = linspace(start_time,end_time,length(lowsignal));
    % display possible seizure zone in lowpass signal
    figure;subplot(2,1,1);
    plot(t(window_start:window_end),lowsignal(window_start:window_end,pos));
    xlabel('Time (sec)');title('Lowpass Signal');ylabel('Amplitude (uV)');
    hold on;
    
    window_start = (i-4)*time_divisions;
    if window_start < 1
        window_start = 1;
    end
    window_end = (i+15)*time_divisions;
    if window_end > length(lowsignal)
        window_end = length(lowsignal);
    end
    % mark with red where the seizure is most likely located
    y1 = get(gca,'ylim');
    plot([window_start window_start],y1,'r');
    plot([window_end window_end],y1,'r'); hold off
    
    
    % display the energy plot to compare with the lowpass signal
    subplot(2,1,2);plot(te,e(:,pos));
    title('Energy Plot');xlabel('Time (sec)');hold on
    % code to mark the area in the energy signal that corresponds to the
    % lowpass signal
    window_start = (i-4)*time_divisions;
    window_end = (i+15)*time_divisions;
    y1 = get(gca,'ylim');
    plot([window_start window_start],y1,'r');
    plot([window_end window_end],y1,'r'); hold off
    
    
    
    
    t = linspace(0,end_time,length(highsignal));
    % 80 second window to look for HFOs in the data
    times = (i-14)*time_divisions*2500;
    if times < 1
        times = 1;
    end
    timee = (i+25)*time_divisions*2500;
    if timee > length(highsignal(:,pos))
        timee = length(highsignal(:,pos));
    end
    % display the area around the marked seizure zone
    figure;subplot(2,1,1);
    plot(t(times:timee),highsignal(times:timee,pos));xlabel('Time (sec)');
    title('Highpass Signal');ylabel('Amplitude (uV)');
    axis('tight');hold on
    
    % code to mark in red where in the signal the seizure marked above would be
    window_start = (i-4)*time_divisions;
    window_end = (i+15)*time_divisions;
    y1 = get(gca,'ylim');
    plot([window_start window_start],y1,'r');
    plot([window_end window_end],y1,'r'); hold off
    
    
    
    % code to display a spectrogram of the same region of the above
    % highpass signal
    start = times;
    step = 60*2500;
    finish = timee;%start + step;
    clims = [20 80];%clims = [20 65]; % this decides the limits for the colors used in the spectrogram
    subplot(2,1,2);
    %spectrogram(highsignal(start:finish,pos),512,500,512,2500,'power','yaxis');
    [spec,w,t] = spectrogram(highsignal(start:finish,pos),512,500,512,2500,'power','yaxis');
    %ax = gca;
    %hold(ax,'on');
    %imagesc(t,w,flipud(20*log10(abs(spec))),clims);colorbar off;
    imagesc(t,w(1:128),20*log10(abs(spec(1:128,:))),clims);colorbar off; % display spectrogram, focusing on frequencies between 0 and 600 Hz
    axis xy
    title('Spectrogram');xlabel('Time (sec)');ylabel('Frequency (kHz)');

    
    % go to the next marked seizure zone that is at least 10 seconds away
    % (assuming time_division is set to 2 seconds)
    i = i + 5;
    next = find(points.index > i);
    if(~isempty(next))
        i = points.index(next(1));
    end
end