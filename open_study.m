clc;
clear all;
path2 = '/Volumes/DanielDisk/HifoCap/epilepsiae_patientdata/data/raw_data/pat_1328803/adm_132880103/rec_13288010103/13288010103_009.data';
study = bin_file(path2);
chosen_electrodes = cellstr(['P4';'O2']);
study.def_data_access(3,3,chosen_electrodes,0);
study.get_notes();
eeg = study.get_bin_signals([],[]);
[event_start,event_end] = study.a_note_struct.sample;
eegDim = size(eeg);
labeledEEG = [eeg;zeros(1,eegDim(2))];
labeledEEG(3,event_start:event_end) = 1;

%%

window_size = 3; %in seconds
window_sample_size = study.a_samp_freq*window_size;
num_of_windows = floor(study.a_n_samples/window_sample_size);


master_window = [];
for channel = 1:eegDim(1)
    index = 1;
    count = 0;
    windows = zeros(num_of_windows,window_sample_size+1);
    while(index < (eegDim(2)-window_sample_size))
        label_value = labeledEEG(3,index);
        window = zeros(1,window_sample_size+1);
        local_index = 1;
        for index_window = index:(index+window_sample_size)
            if(labeledEEG(3,index_window) ~= label_value)
                break;
            else
                window(local_index) = labeledEEG(channel,index_window);
            end
            local_index = local_index + 1;
        end
        index = index_window;
        window(end) = label_value;
        windows(count+1,1:end) = window;
        count = count + 1;
    end
    master_window = [master_window;windows];
end
    
