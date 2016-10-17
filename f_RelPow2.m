function v_RelPow = f_RelPow2(pv_Sig, ps_SamRate, pm_FreqRanges, ps_ARMethod)
% 
% Function: f_RelPow.m
% 
% Description: 
% This function computes the relative power of particular spectral bands
% for the input signal.
% 
% Inputs:
% pv_Sig: input signal
% ps_SamRate: sample rate in Hz
% pm_FreqRangesHz: nx2 matrix containing the ranges of desired frequency
% bands to compute the relative power. n  is the number of frequency bands.
% Example: [0.1 4;4 8], computes the relative power for bands between 0.1
% to 4 Hz and between 4 and 8 Hz
% ps_ARMethod (optional): set to 1 to compute the power spectral density
% via an AR (Autoregressive) model estimator. Default: 0 (FFT squared
% modulus estimator) 
% 
% Outputs:
% v_RelPow: array of length n containing the relative power for each
% frequency band 
% v_PowSpec: array containing the power spectrum for frequencies from 0 to
% the half of the sample rate
% v_Freq: array containing the frequency values from 0 to the half of the
% sample rate
% 
% MATLAB Version: R2007b
% 
% Team: LENA
% Author: Mario Valderrama
%
    
    v_RelPow = [];

    if nargin < 3
        error('[v_RelPow] - ERROR: bad number of inputs!');
    end    
    
    s_ARMethod = 0;
    if nargin >= 4 && ~isempty(ps_ARMethod)
        s_ARMethod = ps_ARMethod;
    end
    
    clear v_PowSpec v_Freq s_TotalPow
    [v_PowSpec, v_Freq, s_TotalPow] = ...
        f_PowSpec(pv_Sig, ps_SamRate, s_ARMethod);
    
    v_RelPow = zeros(size(pm_FreqRanges, 1), 1);

    for s_Counter = 1:size(pm_FreqRanges, 1)
        clear v_Ind
        v_Ind = find(v_Freq >= pm_FreqRanges(s_Counter, 1) & ...
            v_Freq <= pm_FreqRanges(s_Counter, 2));
        v_RelPow(s_Counter) = sum(v_PowSpec(v_Ind))./ s_TotalPow;
    end
    
    clear v_Ind
    
    if nargout < 3
        clear v_Freq
        if nargout < 2
            clear v_PowSpec
        end
    end
    
    
    