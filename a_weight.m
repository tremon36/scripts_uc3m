function weights = a_weight(f)
%function weights = a_weight(f)
% calculate the a-weighting for the given frequency/frequencies
% result is linear (not dB)
weights=((12200^2*f.^4)./((f.^2+20.6^2) .*(f.^2+12200^2) .*(sqrt(f.^2+107.7^2)) .*(sqrt(f.^2+737.9^2)))).*1.259987;
%%%%a_weight_y_db=20*log10(a_weight_y+1e-8);
end
