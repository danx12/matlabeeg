path2 = './surf30/pat_22602/adm_226102/*/**/*.data';
files = rdir(path2);
files = {files.name};


%%
master_window_ch0 = [];
master_window_ch1 = [];
master_window_ch2 = [];

for i=1:length(files)
    disp(['Process ' int2str(i) ' of ' int2str(length(files))]);
    window0 = open_study_function(files{i},['CZ'],3);
    window1 = open_study_function(files{i},['F3'],3);
    window2 = open_study_function(files{i},['C3'],3);
    
%      eval(['dataInFile_' int2str(i) '= open_study_function(files{i},[''CZ'';''F3'';''C3''],1);']);
end
     
 master_window_ch0 = vertcat(master_window_ch0,window0);
 master_window_ch1 = vertcat(master_window_ch1,window1);
 master_window_ch2 = vertcat(master_window_ch2,window2);


%%

notify();
