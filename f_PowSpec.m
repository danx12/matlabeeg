function [v_PowSpec v_Freq s_TotalPow] = f_PowSpec(  pv_Sig, ps_SamRate, ps_ARMethod)
% 
% Function: f_PowSpec.m
% 
% Description: 
% This function computes the power spectrum of the input signal.
% 
% Inputs:
% pv_Sig: input signal
% ps_SamRate: sample rate in Hz
% ps_ARMethod (optional): set to 1 to compute the power spectral density
% via an AR (Autoregressive) model estimator. Default: 0 (FFT squared
% modulus estimator) 
% 
% Outputs:
% v_PowSpec: array containing the power spectrum for frequencies from 0 to
% the half of the sample rate
% v_Freq: array containing the frequency values from 0 to the half of the
% sample rate
% s_TotalPow: sum of the power for frequencies from 0 to half of the sample
% rate
% 
% MATLAB Version: R2007b
% 
% Team: LENA
% Author: Mario Valderrama
%
    
    if nargin < 3
        error('[v_RelPow] - ERROR: bad number of inputs!');
    end    
    
    s_ARMethod = 0;
    if exist('ps_ARMethod', 'var') && ~isempty(ps_ARMethod)
        s_ARMethod = ps_ARMethod;
    end
    
    switch s_ARMethod,
        case 0, % FFT squared modulus
            v_PowSpec = fft(pv_Sig);
            v_PowSpec = v_PowSpec.* conj(v_PowSpec);
            v_PowSpec = v_PowSpec./ ps_SamRate;
            v_Freq = (0:length(v_PowSpec) - 1).* (ps_SamRate / length(v_PowSpec));
            s_LenHalf = floor(length(v_Freq)./ 2);
            v_PowSpec = v_PowSpec(1:s_LenHalf);
            v_Freq = v_Freq(1:s_LenHalf);
            
        case 1, % Burg method
            s_AROrder = 10;
            if length(pv_Sig) < s_AROrder * 5
                s_AROrder = round(length(pv_Sig) / 5);
            end
            [v_PowSpec, v_Freq] = pburg(double(pv_Sig), s_AROrder, ...
                length(pv_Sig), ps_SamRate);
            
        otherwise,
            return;
            
    end

    if nargout >= 3
        s_TotalPow = sum(v_PowSpec);
    end
    if nargout < 2
        clear v_Freq
    end
    
    
    