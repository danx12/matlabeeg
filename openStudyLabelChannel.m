%%
path2 = '/Volumes/DANFIT1/HifoCap/epilepsiae_patientdata/data/raw_data/pat_1328803/adm_132880103/*/**/*.data';
files = rdir(path2);
fileNames = {files.name};
fileIdxEvents = [];
%%

for i=1:length(fileNames)
    disp(['Computing channel-label data for file: ' int2str(i) ' of ' int2str(length(files))]);
    study = bin_file(fileNames{i});
    chosen_electrodes = cellstr(['T4';'C4';'F7']);
    study.def_data_access(3,3,chosen_electrodes,0);
    study.get_notes();
    eeg = study.get_bin_signals([],[]);

    eegDim = size(eeg);
    labeledEEG = [eeg;zeros(1,eegDim(2))];
    flag = 'normal';
    if ~isempty(study.a_note_struct)
        [event_start,event_end] = study.a_note_struct.sample;
        labeledEEG(eegDim(1)+1,event_start:event_end) = 1;
        disp(['File ' int2str(i) ' contains events']);
        flag = 'events';
        fileIdxEvents = vertcat(fileIdxEvents,i);
    end 
    
    eval(['FileEEGData_' chosen_electrodes{:} '_' flag '_' int2str(i)  '=' 'labeledEEG;']);
    clear eeg;
    clear labeledEEG;
end
%%

filesWithEvents = fileNames(fileIdxEvents(:));

%%
notify();

