%% Separate master window into data and labels
clear onlyData;
clear onlyLabels;

data = master_window(:,1:end-1);
labels = master_window(:,end);

%% Compute Features and determine execution time

execTimeFeatures = zeros(60,1);
sampleFrequency = 400;
%Format:
%[#Feature,execTimeFeatures(#,:)] = evaluateFeature(@#,data);

%%
disp('Computing statistical features');
[meanFeature,execTimeFeatures(1,:)] = evaluateFeature(@mean,data);
[skewnessFeature,execTimeFeatures(2,:)] = evaluateFeature(@skewness,data);
[kurtosisFeature,execTimeFeatures(3,:)] = evaluateFeature(@kurtosis,data);

%%
disp('Computing AR features');
[AR_CoeffBurg10Feature,execTimeFeatures(4,:)] = evaluateFeature(@f_ARCoeff,data,10,'burg');
[AR_CoeffCov10Feature,execTimeFeatures(5,:)] = evaluateFeature(@f_ARCoeff,data,10,'cov');
[AR_CoeffMcov10Feature,execTimeFeatures(6,:)] = evaluateFeature(@f_ARCoeff,data,10,'mcov');
[AR_CoefYule10Feature,execTimeFeatures(7,:)] = evaluateFeature(@f_ARCoeff,data,10,'yule');
[AR_CoeffLpc10Feature,execTimeFeatures(8,:)] = evaluateFeature(@f_ARCoeff,data,10,'lpc');

%%
disp('Computing Power features');
[PowDeltaFeature,execTimeFeatures(9,:)] = evaluateFeature(@f_RelPow2,data,sampleFrequency,[0.1 4]);
[PowThetaFeature,execTimeFeatures(10,:)] = evaluateFeature(@f_RelPow2,data,sampleFrequency,[4.1 7]);
[PowAlphaFeature,execTimeFeatures(11,:)] = evaluateFeature(@f_RelPow2,data,sampleFrequency,[7.1 15]);
[PowBetaFeature,execTimeFeatures(12,:)] = evaluateFeature(@f_RelPow2,data,sampleFrequency,[15.1 31]);
[PowGamma1Feature,execTimeFeatures(13,:)] = evaluateFeature(@f_RelPow2,data,sampleFrequency,[31.1 64]);
[PowGamma2Feature,execTimeFeatures(14,:)] = evaluateFeature(@f_RelPow2,data,sampleFrequency,[64.1 128]);

%%
disp('Computing SEF features');
[SEF50Feature,execTimeFeatures(15,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,50);
[SEF60Feature,execTimeFeatures(16,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,60);
[SEF70Feature,execTimeFeatures(17,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,70);
[SEF75Feature,execTimeFeatures(18,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,75);
[SEF80Feature,execTimeFeatures(19,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,80);
[SEF85Feature,execTimeFeatures(20,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,85);
[SEF90Feature,execTimeFeatures(21,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,90);
[SEF92Feature,execTimeFeatures(22,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,92);
[SEF95Feature,execTimeFeatures(23,:)] = evaluateFeature(@f_SpecEdgeFreq2,data,sampleFrequency,sampleFrequency/2.0,95);

%%
disp('Computing Decorr features');
[DecorrTimeFeature,execTimeFeatures(24,:)] = evaluateFeature(@f_DecorrTime2,data,sampleFrequency);

%%
disp('Computing Hjorth features');
[HjorthMobilFeature,execTimeFeatures(25,:)] = evaluateFeature(@f_Hjorth,data,sampleFrequency,0);
[HjorthComplxFeature,execTimeFeatures(26,:)] = evaluateFeature(@f_Hjorth,data,sampleFrequency,1);

%%
disp('Computing Entropy features');
[SampEnFeature,execTimeFeatures(27,:)] = evaluateFeature(@f_sampen2,data,3,2);
[ApEnFeature,execTimeFeatures(28,:)] = evaluateFeature(@f_apen_est2,data);

%%
disp('Computing Wavelet DB features');
[WaveletDb2Dec1Feature,execTimeFeatures(29,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db2',1);
[WaveletDb2Dec2Feature,execTimeFeatures(30,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db2',2);
[WaveletDb2Dec3Feature,execTimeFeatures(31,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db2',3);
[WaveletDb2Dec4Feature,execTimeFeatures(32,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db2',4);
[WaveletDb2Dec5Feature,execTimeFeatures(33,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db2',5);
[WaveletDb2Dec6Feature,execTimeFeatures(34,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db2',6);

[WaveletDb4Dec1Feature,execTimeFeatures(35,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db4',1);
[WaveletDb4Dec2Feature,execTimeFeatures(36,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db4',2);
[WaveletDb4Dec3Feature,execTimeFeatures(37,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db4',3);
[WaveletDb4Dec4Feature,execTimeFeatures(38,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db4',4);
[WaveletDb4Dec5Feature,execTimeFeatures(39,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db4',5);
[WaveletDb4Dec6Feature,execTimeFeatures(40,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db4',6);

[WaveletDb6Dec1Feature,execTimeFeatures(41,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db6',1);
[WaveletDb6Dec2Feature,execTimeFeatures(42,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db6',2);
[WaveletDb6Dec3Feature,execTimeFeatures(43,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db6',3);
[WaveletDb6Dec4Feature,execTimeFeatures(44,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db6',4);
[WaveletDb6Dec5Feature,execTimeFeatures(45,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db6',5);
[WaveletDb6Dec6Feature,execTimeFeatures(46,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db6',6);

[WaveletDb8Dec1Feature,execTimeFeatures(47,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db8',1);
[WaveletDb8Dec2Feature,execTimeFeatures(48,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db8',2);
[WaveletDb8Dec3Feature,execTimeFeatures(49,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db8',3);
[WaveletDb8Dec4Feature,execTimeFeatures(50,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db8',4);
[WaveletDb8Dec5Feature,execTimeFeatures(51,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db8',5);
[WaveletDb8Dec6Feature,execTimeFeatures(52,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'db8',6);

%%
disp('Computing Wavelet Haar features');
[WaveletHaarDec1Feature,execTimeFeatures(53,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'haar',1);
[WaveletHaarDec2Feature,execTimeFeatures(54,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'haar',2);
[WaveletHaarDec3Feature,execTimeFeatures(55,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'haar',3);
[WaveletHaarDec4Feature,execTimeFeatures(56,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'haar',4);
[WaveletHaarDec5Feature,execTimeFeatures(57,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'haar',5);
[WaveletHaarDec6Feature,execTimeFeatures(58,:)] = evaluateFeature(@wav_coef,data,sampleFrequency,'haar',6);

%%
disp('Computing Energy features');
[ShortEnergyFeature,execTimeFeatures(59,:)] = evaluateFeature(@energy2,data);

%%
disp('Computing simple linear features');
[RMSFeature,execTimeFeatures(60,:)] = evaluateFeature(@rms,data);
[LineLengthFeature,execTimeFeatures(61,:)] = evaluateFeature(@f_linelength,data);
[LocalMaxFeature,execTimeFeatures(62,:)] = evaluateFeature(@max,data);
[LocalMinFeature,execTimeFeatures(63,:)] = evaluateFeature(@min,data);

%% Create EEG Activity Table

eegTrainActivity = table(meanFeature,skewnessFeature,kurtosisFeature,AR_CoeffBurg10Feature,AR_CoeffCov10Feature,AR_CoeffMcov10Feature,...
AR_CoefYule10Feature,AR_CoeffLpc10Feature,PowDeltaFeature,PowThetaFeature,PowAlphaFeature,PowBetaFeature,PowGamma1Feature,PowGamma2Feature,...
SEF50Feature,SEF60Feature,SEF70Feature,SEF75Feature,SEF80Feature,SEF85Feature,SEF90Feature,SEF92Feature,SEF95Feature,DecorrTimeFeature,HjorthMobilFeature,...
HjorthComplxFeature,SampEnFeature,ApEnFeature,WaveletDb2Dec1Feature,WaveletDb2Dec2Feature,WaveletDb2Dec3Feature,WaveletDb2Dec4Feature,WaveletDb2Dec5Feature,...
WaveletDb2Dec6Feature,WaveletDb4Dec1Feature,WaveletDb4Dec2Feature,WaveletDb4Dec3Feature,WaveletDb4Dec4Feature,WaveletDb4Dec5Feature,...
WaveletDb4Dec6Feature,WaveletDb6Dec1Feature,WaveletDb6Dec2Feature,WaveletDb6Dec3Feature,WaveletDb6Dec4Feature,WaveletDb6Dec5Feature,...
WaveletDb6Dec6Feature,WaveletDb8Dec1Feature,WaveletDb8Dec2Feature,WaveletDb8Dec3Feature,WaveletDb8Dec4Feature,WaveletDb8Dec5Feature,...
WaveletDb8Dec6Feature,WaveletHaarDec1Feature,WaveletHaarDec2Feature,WaveletHaarDec3Feature,WaveletHaarDec4Feature,WaveletHaarDec5Feature,...
WaveletHaarDec6Feature,ShortEnergyFeature,RMSFeature,LineLengthFeature,LocalMaxFeature,LocalMinFeature,labels);


%% Notify mobile when done
webread('https://maker.ifttt.com/trigger/spyder/with/key/ou3_qyIHH3IV22kLJrvLT_AJLLNR8PyUqu8dmZvIlGH');




