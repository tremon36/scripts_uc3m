function [alpha,clk,data_HDR,data_HSNR] = import_gologic_DOG15(file_path, use_DDR) 

   data_raw = readmatrix(file_path);

    % To get CLK, divide by 10^12 as integer

    clk = floor(data_raw / 10^12);

    % To get Alpha, get mod 10 (last bit)

    alpha = mod(data_raw, 10);

    % To get data, get bits in between (divide by ten, perform mod 10^11)

    data = floor(data_raw / 10);
    data = mod(data, 1e11);
    
    % Convert to binary

    data = bin2int(data,11);

     if (use_DDR)
        [data_HDR,data_HSNR] = split_ddr(data,clk);
    else 
        data_HDR = data;
        data_HSNR = data;
    end
    
    

end