function [dataArray,headerData] = readFileandHeader(path,name)

headerFile = fopen(strcat(path,'\',name,'.head'),'rt');

if headerFile == -1
    display(['Eror opening header file:' headName])
    return;
end

while 1
    str_Line = fgetl(headerFile);
    if ~ischar(str_Line)
        break;
    end
    [str_Token, str_Remain] = strtok(str_Line, '=');
    str_Token = strtrim(str_Token);
    if ~isempty(str_Remain) && length(str_Remain) >= 2
        str_Remain = str_Remain(2:end);
        str_Remain = strtrim(str_Remain);
    else
        continue;
    end
    if strcmpi(str_Token, 'START_TS')
        a_start_ts = str_Remain;
        a_start_ts=datestr(datenum(a_start_ts,'yyyy-mm-dd HH:MM:SS'),'yyyy-mm-dd HH:MM:SS');
    end
    if strcmpi(str_Token, 'NUM_SAMPLES')
        a_n_samples = str2num(str_Remain);
    end
    if strcmpi(str_Token, 'SAMPLE_FREQ')
        a_samp_freq = str2num(str_Remain);
    end
    if strcmpi(str_Token, 'CONVERSION_FACTOR')
        a_conv_factor = str2num(str_Remain);
    end
    if strcmpi(str_Token, 'NUM_CHANNELS')
        a_n_chan = str2num(str_Remain);
    end
    if strcmpi(str_Token, 'ELEC_NAMES')
        a_file_elec_str = str_Remain;
        if a_file_elec_str(1) == '['
            a_file_elec_str = a_file_elec_str(2:end);
        end
        if a_file_elec_str(end) == ']'
            a_file_elec_str = a_file_elec_str(1:end - 1);
        end
    end
    if strcmpi(str_Token, 'PAT_ID')
        a_pat_id = str2num(str_Remain);
    end
    if strcmpi(str_Token, 'SAMPLE_BYTES')
        a_n_bytes = str2num(str_Remain);
    end

end

disp(a_n_bytes)

fclose(headerFile);





