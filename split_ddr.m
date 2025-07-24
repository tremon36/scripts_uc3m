function [data_HDR,data_HSNR] = split_ddr(DDR_data,CLK_data)

        if (CLK_data(1) == 0)
            data_HDR = DDR_data(1:2:end);
            data_HSNR = DDR_data(2:2:end);
        else
            data_HDR = DDR_data(2:2:end);
            data_HSNR = DDR_data(1:2:end);
        end
  
end