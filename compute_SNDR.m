function [freqs,data_fft,SNDR,SNDR_aw] = compute_SNDR(data,ft,fs,bandwidth,hanning_order,remove_mean)

    if nargin < 6
       remove_mean = false;
    end

    u0 = data;
    fbin = fs/length(u0);
    binbw = bandwidth/fbin;
    bint = floor(length(data)*ft/fs)+1;

    if remove_mean
        u0 = u0 - mean(u0);
    end
    
    % No aw

    [data_fft,freqs] = FC_psd_hanning(u0,fs,hanning_order);
    
    eu0 = data_fft;
    sig=eu0(bint-hanning_order:bint+hanning_order);
    eu0(bint-hanning_order:bint+hanning_order)= 0;
    noi=eu0(3:binbw);

    SNDR = 10*log10(sum(sig)/sum(noi));

    % aw
    
    eu0 = data_fft .* a_weight(freqs).^2;
    sig=eu0(bint-hanning_order:bint+hanning_order);
    eu0(bint-hanning_order:bint+hanning_order)= 0;
    noi=eu0(3:binbw);

    SNDR_aw = 10*log10(sum(sig)/sum(noi));

end