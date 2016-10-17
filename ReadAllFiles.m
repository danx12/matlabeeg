clc; clear all;
path2 = '/Volumes/DANFIT1/HifoCap/epilepsiae_patientdata/data/raw_data/pat_1328803/adm_132880103/*/**/*.data';
files = rdir(path2);
files = {files.name};

%%
allwindow = [];
for i=1:length(files)
    disp(['Process ' int2str(i) ' of ' int2str(length(files))]);
    window = open_study_function(files{i},['P4';'O2'],3);
    allwindow = vertcat(allwindow,window);
end