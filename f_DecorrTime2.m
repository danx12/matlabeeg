function s_DecorrTime = f_DecorrTime2(pv_Sig,ps_SamRate)
% 
% Function: f_DecorrTime.m
% 
% Description: 
% This function computes the decorrelation time which is an estimator of
% the range of linear correlations of a signal. The decorrelation time can
% be defined using the first zero crossing of the autocorrelation function.
% For more information see Mormann et al., 2005.
% 
% Inputs:
% pv_Sig: input signal
% ps_SamRate (optional): sample rate in Hz. Default: 1 Hz
% 
% Outputs:
% s_DecorrTime: the decorrelation time in seconds
% 
% MATLAB Version: R2007b
% 
% Team: LENA
% Author: Mario Valderrama
%
    
    s_DecorrTime = [];
    
    if nargin < 1
        error('[s_DecorrTime] - ERROR: bad number of inputs!');
    end    
    
    s_SamRate = 1;
    if nargin >= 2 && ~isempty(ps_SamRate)
        s_SamRate = ps_SamRate;
    end
    
    s_DecorrTime = xcorr(double(pv_Sig), 'unbiased');
    s_DecorrTime = find(s_DecorrTime(length(pv_Sig):end) <= 0, 1);
    if isempty(s_DecorrTime)
        s_DecorrTime = -1;
    else
        s_DecorrTime = s_DecorrTime - 1;
        s_DecorrTime = s_DecorrTime./ s_SamRate;
    end
    
    
    
    
    
    