clear all; close all; clc;
%%
% First thing we must do is open and save the EEG data that we wish to
% process.
%data = fopen('73200102_0004.data','r'); % 75 channel data
data = fopen('73207102_0014.data','r');% 102 channel data

eeg = fread(data,'int32'); % 4 bytes per sample
fclose(data);

%eeg = reshape(eeg,75,[]); % 75 channel data
eeg = reshape(eeg,102,[]); % 102 channel data
eeg = eeg*0.298000; % conversion factor to convert signal into uV

%%
% We need to define the filters that will be used to process the raw EEG
% data. A lowpass filter is used to search for seizures while a highpass
% filter is used to work with HFOs.

% IIR highpass filter used to remove bias from lowpass signal
b = [1 -2 1];
a = [1 -1.99887723692173 0.998878605642483];

% FIR filters to do the major filtering 
Low = lowpass; % lowpass filter defined by lowpass function
High = highpass; % highpass filter defined by highpass function
Band = bandpass; % bandpass filter defined by bandpass function

% code to filter the signals for processing
% 75 - 95 are scalp EEGs
%  1 - 64 are grid  EEGs
for i = 75:95%1:64 % loop through the given channels of the EEG
    %%
    %signal = downsample(eeg(i,1:3000000),25); % work in progress
    
    Fs = 2500; % sampling frequency of signals
    signal = filter(b,a,eeg(i,1:3000000)); % apply IIR highpass filter to remove bias
    
    
    
    %%
    cut = Fs*4; % cut the first four seconds of the signal to remove leftovers of the bias
    signal = signal(cut:end);
    

    
    %%
    lowsignal(:,i) = filter(Low,1,signal); % lowpass filter to find seizures
    

    highsignal(:,i) = filter(Band,1,eeg(i,1:3000000)); % highpass filter to look at HFOs
end