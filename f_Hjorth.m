function result = f_Hjorth(pv_Sig, ps_SamRate,select)
% 
% Function: f_Hjorth.m
% 
% Description: 
% This function computes the Hjorth mobility and complexity as defined in
% Mormann et al., 2005.
% 
% Inputs:
% pv_Sig: input signal
% ps_SamRate: sample rate in Hz
%select: 0-mobility, 1-complexity
% 
% Outputs:
% s_HM: Hjorth mobility
% s_HC: Hjorth complexity
% 
% MATLAB Version: R2007b
% 
% Team: LENA
% Author: Mario Valderrama
%



clear v_PowSpec v_Freq s_TotalPow
[v_PowSpec, v_Freq, s_TotalPow] = f_PowSpec(pv_Sig, ps_SamRate, 0);

if select
    %mobility
    v_Freq = v_Freq.* v_Freq;
    result = sum(v_PowSpec(:).* v_Freq(:))./ s_TotalPow;
else
    %complexity
    v_Freq = v_Freq.* v_Freq;
    v_Freq = v_Freq.* v_Freq;
    result = sum(v_PowSpec(:).* v_Freq(:))./ s_TotalPow;
end

clear v_Freq

