function [time,execTimeFeatures] = getFeatureTime(data)

    %% Compute Features and determine execution time

    execTimeFeatures = zeros(60,1);
    sampleFrequency = 400;
    %Format:
    %[#Feature,execTimeFeatures(#,:)] = evaluateFeature(@#,data(1,:));

    %%
   
    %('Computing statistical features');
    [meanFeature,execTimeFeatures(1,:)] = evaluateFeature(@mean,data(1,:));
    [skewnessFeature,execTimeFeatures(2,:)] = evaluateFeature(@skewness,data(1,:));
    [kurtosisFeature,execTimeFeatures(3,:)] = evaluateFeature(@kurtosis,data(1,:));

    %%
    %('Computing AR features');
    [AR_CoeffBurg10Feature,execTimeFeatures(4,:)] = evaluateFeature(@f_ARCoeff,data(1,:),10,'burg');
    [AR_CoeffCov10Feature,execTimeFeatures(5,:)] = evaluateFeature(@f_ARCoeff,data(1,:),10,'cov');
    [AR_CoeffMcov10Feature,execTimeFeatures(6,:)] = evaluateFeature(@f_ARCoeff,data(1,:),10,'mcov');
    [AR_CoefYule10Feature,execTimeFeatures(7,:)] = evaluateFeature(@f_ARCoeff,data(1,:),10,'yule');
    [AR_CoeffLpc10Feature,execTimeFeatures(8,:)] = evaluateFeature(@f_ARCoeff,data(1,:),10,'lpc');

    %%
    %('Computing Power features');
    [PowDeltaFeature,execTimeFeatures(9,:)] = evaluateFeature(@f_RelPow2,data(1,:),sampleFrequency,[0.1 4]);
    [PowThetaFeature,execTimeFeatures(10,:)] = evaluateFeature(@f_RelPow2,data(1,:),sampleFrequency,[4.1 7]);
    [PowAlphaFeature,execTimeFeatures(11,:)] = evaluateFeature(@f_RelPow2,data(1,:),sampleFrequency,[7.1 15]);
    [PowBetaFeature,execTimeFeatures(12,:)] = evaluateFeature(@f_RelPow2,data(1,:),sampleFrequency,[15.1 31]);
    [PowGamma1Feature,execTimeFeatures(13,:)] = evaluateFeature(@f_RelPow2,data(1,:),sampleFrequency,[31.1 64]);
    [PowGamma2Feature,execTimeFeatures(14,:)] = evaluateFeature(@f_RelPow2,data(1,:),sampleFrequency,[64.1 128]);

    %%
    %('Computing SEF features');
    [SEF50Feature,execTimeFeatures(15,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,50);
    [SEF60Feature,execTimeFeatures(16,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,60);
    [SEF70Feature,execTimeFeatures(17,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,70);
    [SEF75Feature,execTimeFeatures(18,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,75);
    [SEF80Feature,execTimeFeatures(19,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,80);
    [SEF85Feature,execTimeFeatures(20,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,85);
    [SEF90Feature,execTimeFeatures(21,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,90);
    [SEF92Feature,execTimeFeatures(22,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,92);
    [SEF95Feature,execTimeFeatures(23,:)] = evaluateFeature(@f_SpecEdgeFreq2,data(1,:),sampleFrequency,sampleFrequency/2.0,95);

    %%
    %('Computing Decorr features');
    [DecorrTimeFeature,execTimeFeatures(24,:)] = evaluateFeature(@f_DecorrTime2,data(1,:),sampleFrequency);

    %%
    %('Computing Hjorth features');
    [HjorthMobilFeature,execTimeFeatures(25,:)] = evaluateFeature(@f_Hjorth,data(1,:),sampleFrequency,0);
    [HjorthComplxFeature,execTimeFeatures(26,:)] = evaluateFeature(@f_Hjorth,data(1,:),sampleFrequency,1);

    %%
    %('Computing Entropy features');
    [SampEnFeature,execTimeFeatures(27,:)] = evaluateFeature(@f_sampen2,data(1,:),3,0.2);
    [ApEnFeature,execTimeFeatures(28,:)] = evaluateFeature(@f_apen_est2,data(1,:));

    %%
    %('Computing Wavelet DB features');
    [WaveletDb2Dec1Feature,execTimeFeatures(29,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db2',1);
    [WaveletDb2Dec2Feature,execTimeFeatures(30,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db2',2);
    [WaveletDb2Dec3Feature,execTimeFeatures(31,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db2',3);
    [WaveletDb2Dec4Feature,execTimeFeatures(32,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db2',4);
    [WaveletDb2Dec5Feature,execTimeFeatures(33,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db2',5);
    [WaveletDb2Dec6Feature,execTimeFeatures(34,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db2',6);

    [WaveletDb4Dec1Feature,execTimeFeatures(35,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db4',1);
    [WaveletDb4Dec2Feature,execTimeFeatures(36,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db4',2);
    [WaveletDb4Dec3Feature,execTimeFeatures(37,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db4',3);
    [WaveletDb4Dec4Feature,execTimeFeatures(38,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db4',4);
    [WaveletDb4Dec5Feature,execTimeFeatures(39,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db4',5);
    [WaveletDb4Dec6Feature,execTimeFeatures(40,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db4',6);

    [WaveletDb6Dec1Feature,execTimeFeatures(41,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db6',1);
    [WaveletDb6Dec2Feature,execTimeFeatures(42,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db6',2);
    [WaveletDb6Dec3Feature,execTimeFeatures(43,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db6',3);
    [WaveletDb6Dec4Feature,execTimeFeatures(44,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db6',4);
    [WaveletDb6Dec5Feature,execTimeFeatures(45,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db6',5);
    [WaveletDb6Dec6Feature,execTimeFeatures(46,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db6',6);

    [WaveletDb8Dec1Feature,execTimeFeatures(47,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db8',1);
    [WaveletDb8Dec2Feature,execTimeFeatures(48,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db8',2);
    [WaveletDb8Dec3Feature,execTimeFeatures(49,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db8',3);
    [WaveletDb8Dec4Feature,execTimeFeatures(50,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db8',4);
    [WaveletDb8Dec5Feature,execTimeFeatures(51,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db8',5);
    [WaveletDb8Dec6Feature,execTimeFeatures(52,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'db8',6);

    %%
    %('Computing Wavelet Haar features');
    [WaveletHaarDec1Feature,execTimeFeatures(53,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'haar',1);
    [WaveletHaarDec2Feature,execTimeFeatures(54,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'haar',2);
    [WaveletHaarDec3Feature,execTimeFeatures(55,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'haar',3);
    [WaveletHaarDec4Feature,execTimeFeatures(56,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'haar',4);
    [WaveletHaarDec5Feature,execTimeFeatures(57,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'haar',5);
    [WaveletHaarDec6Feature,execTimeFeatures(58,:)] = evaluateFeature(@wav_coef,data(1,:),sampleFrequency,'haar',6);

    %%
    %('Computing Energy features');
    [ShortEnergyFeature,execTimeFeatures(59,:)] = evaluateFeature(@energy2,data(1,:));

    %%
    %('Computing simple linear features');
    [RMSFeature,execTimeFeatures(60,:)] = evaluateFeature(@rms,data(1,:));
    [LineLengthFeature,execTimeFeatures(61,:)] = evaluateFeature(@f_linelength,data(1,:));
    [LocalMaxFeature,execTimeFeatures(62,:)] = evaluateFeature(@max,data(1,:));
    [LocalMinFeature,execTimeFeatures(63,:)] = evaluateFeature(@min,data(1,:));


    %% Get Approx time
    numOfWindows = size(data);
    numOfWindows = numOfWindows(1);
    time = sum(execTimeFeatures(:)) .* numOfWindows;
    disp(['Estimated time: ' secs2hms(time)]);
    clearvars -except master_window data labels time execTimeFeatures;
    
end
