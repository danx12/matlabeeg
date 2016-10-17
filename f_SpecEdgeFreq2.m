function s_SEF = f_SpecEdgeFreq2(pv_Sig, ps_SamRate, ps_FreqRef, ps_Per, ps_MinFreq, ps_ARMethod)
% 
% Function: f_SpecEdgeFreq.m
% 
% Description: 
% This function computes the Spectral Edge Frequency (SPE) defined by the
% minimal frequency below which x percent of the total power (or the power
% at some reference frequency) of a given signal are located.
% 
% Inputs:
% pv_Sig: input signal
% ps_SamRate: sample rate in Hz
% ps_FreqRef (optional): reference frequency. Default: half of the sample
% rate
% ps_Per (optional): percentage used to obtain the edge frequency (value in
% percentage). Default: 50
% ps_MinFreq (optional): minimal frequency from which the spectral edge
% frequency will be obtained. Default: 0 Hz
% ps_ARMethod (optional): set to 1 to compute the power spectral density
% via an AR (Autoregressive) model estimator. Default: 0 (FFT squared
% modulus estimator) 
% 
% Outputs:
% s_SEF: the spectral edge frequency
% s_EdgePow: the power at this frequency
% 
% MATLAB Version: R2007b
% 
% Team: LENA
% Author: Mario Valderrama
%
    
    if nargin < 2
        error('[f_SpecEdgeFreq] - ERROR: bad number of inputs!');
    end    
    
    s_FreqRef = ps_SamRate / 2;
    s_Per = 50;
    s_MinFreq = 0;
    s_ARMethod = 0;
    if nargin >= 3 && ~isempty(ps_FreqRef)
        s_FreqRef = ps_FreqRef;
    end
    if nargin >= 4 && ~isempty(ps_Per)
        s_Per = ps_Per;
    end
    if nargin >= 5 && ~isempty(ps_MinFreq)
        s_MinFreq = ps_MinFreq;
    end
    if nargin >= 6 && ~isempty(ps_ARMethod)
        s_ARMethod = ps_ARMethod;
    end
    
    clear v_PowSpec v_Freq s_TotalPow
    [v_PowSpec, v_Freq] = f_PowSpec(pv_Sig, ps_SamRate, s_ARMethod);    
    
    if s_MinFreq == 0
        s_MinFreqInd = 1;
    else
        s_MinFreqInd = find(v_Freq >= s_MinFreq, 1); 
    end
    s_RefFreqInd = find(v_Freq >= s_FreqRef, 1);
    s_RefPow = sum(v_PowSpec(1:s_RefFreqInd));
    s_RefPow = s_RefPow * (s_Per / 100);
    s_SEF = find(cumsum(v_PowSpec(s_MinFreqInd:s_RefFreqInd)) >= s_RefPow, 1);
    if ~isempty(s_SEF)
        s_SEF = s_SEF + s_MinFreqInd - 1;
    else
%         s_EdgePow = -1;
        s_SEF = -1;
        return;
    end
    if nargout >= 2
%         s_EdgePow = v_PowSpec(s_SEF);
    end
    s_SEF = v_Freq(s_SEF);
    
