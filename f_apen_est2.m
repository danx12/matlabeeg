function v_AppEn = f_apen_est(pv_DataIn)

  [s_m, s_n] = size(pv_DataIn);
    
    if s_m == 1
        pv_DataIn = pv_DataIn(:);
        s_m = length(pv_DataIn);
        s_n = 1;
    end
    v_AppEn = zeros(s_n, 1);
    
    for s_Counter = 1:s_n
        rs = std(pv_DataIn(:,s_Counter));
        if ~isempty(rs)
            r = 0.25*rs;
        end
        P = 0;
        Pi = 0;
        A = 0;
        B = 0;
        ApEn = 0;
        D1 = 0;
        D2 = 0;
        DA = 0;

        for i=1:s_m-2
            for j=(i+1):s_m-3
                D1 = abs(pv_DataIn(i) - pv_DataIn(j));
                D2 = abs(pv_DataIn(i+1) - pv_DataIn(j+1));
                D3 = abs(pv_DataIn(i+2) - pv_DataIn(j+2));

                if(D1>=D2)
                    DA = D1;
                else
                    DA = D2;
                end

                if DA<r
                    A=A+1;
                    if D3<r
                        B = B+1;
                    end
                end

            end

            if (A>0)&&(B>0)
                Pi = (B/A);
                P = P+log(Pi);

            end
        end
        
        ApEn =((-2)*P*(1/(s_m-2)));
    v_AppEn(s_Counter) =  ApEn;

    end
    
   
