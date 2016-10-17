 function result = wav_coef(p_segment, p_samp_rate,mother_wav, dec_level)

                cd = [];
                upsampled_cd = [];

                % perform a multi-level decomposition of the signal using mother wavelet - mother_wavelet
                [C,L] = wavedec (p_segment, dec_level, mother_wav);

                % extraction of the aproximation and details coeficients
                for m = 1:(dec_level)
                    eval(['cd{' int2str(m) '} = detcoef(C,L,m);']);
                end

                % upsampling
                for n = 1:(dec_level)
                    eval(['upsampled_cd{' int2str(n) '} = upsample(cd{' int2str(n) '}, 2^n );']);
                    matrix_size (n)= length (eval(['upsampled_cd{' int2str(n) '}']));
                end

                maxL = max (matrix_size);

                for n = 1:(dec_level)
                    dif = maxL - (length (eval(['upsampled_cd{' int2str(n) '}'])));
                    add = zeros(1,dif);
                    eval(['upsampled_cd{' int2str(n) '} = horzcat(upsampled_cd{' int2str(n) '},add);']);
                    decomposition_coefficients (n,:) = (eval(['upsampled_cd{' int2str(n) '}']));
                end

                % Energy calculation
                wav_result = zeros(dec_level,1);
                for j = 1:dec_level

                    % signal energy (^2) pointxpoint
                    decomposition_coefficients_ = decomposition_coefficients(j,:).^2;
                    a = length(decomposition_coefficients_);
                    wav_result(j) = (sum(decomposition_coefficients_)/a);
                    
                end
               
                result = wav_result(dec_level);

            end