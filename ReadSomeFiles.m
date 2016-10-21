%%
master_window = [];
files = filesWithEvents;
for i=1:length(filesWithEvents)
    disp(['Process ' int2str(i) ' of ' int2str(length(files))]);
    window = open_study_function(files{i},['T4';'C4';'F7'],3);
    master_window = vertcat(master_window,window);
end

%%

notify();