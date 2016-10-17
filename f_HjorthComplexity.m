function [s_HM s_HC] = f_Hjorth(obj, pv_Sig, ps_SamRate, ps_ARMethod)
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
% ps_ARMethod (optional): set to 1 to compute the power spectral density
% via an AR (Autoregressive) model estimator. Default: 0 (FFT squared
% modulus estimator) 
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

if nargin < 1
    error('[f_Hjorth] - ERROR: bad number of inputs!');
end

s_ARMethod = 0;
if exist('ps_ARMethod', 'var') && ~isempty(ps_ARMethod)
    s_ARMethod = ps_ARMethod;
end

clear v_PowSpec v_Freq s_TotalPow
[v_PowSpec v_Freq s_TotalPow] = f_PowSpec(pv_Sig, ps_SamRate, s_ARMethod);

v_Freq = v_Freq.* v_Freq;
s_HM = sum(v_PowSpec(:).* v_Freq(:))./ s_TotalPow;
v_Freq = v_Freq.* v_Freq;
s_HC = sum(v_PowSpec(:).* v_Freq(:))./ s_TotalPow;

clear v_Freq

