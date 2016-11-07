path2 = './surf30/pat_22602/adm_226102/*/**/*.data';
files = rdir(path2);
files = {files.name};


%%
% master_window = [];
for i=1:length(files)
    disp(['Process ' int2str(i) ' of ' int2str(length(files))]);
%     window = open_study_function(files{i},['CZ';'F3';'C3'],3);
    eval(['dataInFile_' int2str(i) '= open_study_function(files{i},[''CZ'';''F3'';''C3''],1);']);
%     master_window = vertcat(master_window,window);
end

%%

notify();
