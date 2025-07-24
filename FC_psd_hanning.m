function [ ey , f ] = FC_psd_hanning( y , fs , hanning_order)
%FC_PSD_HANNING
% Calcula la densidad espectral de potencia (1- sided PSD, en Vrms^2/Hz,
% con toda la potencia distribuida entre DC y fs/2). 
% Usa ventana de Hanning ('periodic')
%
%  [ ey , f ] = FC_psd_hanning( y , fs )
%  ey = 1-sided PSD en Vrms^2/Hz
%  f = Vector de frecuencias
%  y = Vector de entrada en V
%  fs = Frecuencia de muestreo en Hz 
%  

[filas,columnas] = size(y);

if columnas>filas 
    y=y';
end
    
    
lsim = length(y);

w=hanning(lsim,'periodic').^hanning_order;

NG = sum(w.^2)/lsim;

ey = (abs ( fft ( y .* w ) )  / lsim ) .^2 /NG;

ey=ey(1:end/2) / (fs/lsim);

ey(2:end) = ey(2:end) * 2;

f = (0 : length(ey)-1) * fs/lsim;
f=f';

end