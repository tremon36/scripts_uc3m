function outFile = make_set_file(samplingMode,samplingFreq,clkEdgeMode)

    fullPath = mfilename('fullpath');
    functionDir = fileparts(fullPath);
    
    inputFile = strcat(functionDir, "\set_files\config_master.set");
    outFile = strcat(functionDir, "\set_files\config_custom.set");

    if (samplingFreq == "clk triggered")
        samplingFreq = "500MHz";
    end

    if (samplingMode == "simple state" || samplingMode == "normal timing") && (samplingFreq == "100MHz" || samplingFreq == "500MHz") && (clkEdgeMode == "falling" || clkEdgeMode == "any" || clkEdgeMode == "rising")

        txt = fileread(inputFile);
        txt_modificado = strrep(txt, '%sampling_mode%', samplingMode);
        txt_modificado = strrep(txt_modificado, '%sampling_freq%', samplingFreq);
        txt_modificado = strrep(txt_modificado, '%clk_mode%', clkEdgeMode);

        fid = fopen(outFile, 'w');
        fwrite(fid, txt_modificado);
        fclose(fid);
    else
        error("Invalid parameters: Check sampling mode, frequency, and clock edge mode." + newline + "Sampling mode: simple state (clk triggered) or normal timing." + newline + "Sampling freq: 100MHz or clk triggered" ...
            + newline + "Clock edge mode: falling or rising or any");
    end
end