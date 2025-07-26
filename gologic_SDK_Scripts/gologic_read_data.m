function [alpha, clk, data_HDR, data_HSNR] = gologic_read_data(manualMode, pdmMode, DDR_mode, clkTriggered, varargin)
    %This function captures and loads data from GoLogic in the case
    %manual mode is deactivated and only loads data from a csv file if
    %operating in manual mode. Only full file path needs to be provided
    %when operating in manual mode.

    p = inputParser;
    addParameter(p, 'saveFileName', 'default_data_export.csv');
    addParameter(p, 'saveDirectory', '');
    parse(p, varargin{:});
   
    if manualMode && ~(any(char(p.Results.saveDirectory)) && any(char(p.Results.saveFileName)))
        error("In manual capture mode, the file path needs to be specified. " + newline + ...
            "Please, input saveDirectory and saveFileName to the funtion.")
    end

    if ~manualMode

        fullPath = mfilename('fullpath');
        functionDir = fileparts(fullPath);
        setDir = strcat(functionDir,"\set_files\");
        
        if pdmMode
            if clkTriggered
                setFile = strcat(setDir,"config_pdm.set");
            else
                setFile = strcat(setDir,"config_pdm_ntrig.set");
            end
        else
            if clkTriggered
                setFile = strcat(setDir,"config4m.set");
            else
                setFile = strcat(setDir,"config_npdm_ntrig.set");
            end
        end

        if clkTriggered
            sample_freq = "clk triggered";
            sample_mode = "simple state";
        else
            sample_freq = "100MHz";
            sample_mode = "normal timing";
        end

        if DDR_mode
            clk_edge_mode = "any";
        else
            clk_edge_mode = "Falling";
        end

        setCustomFile = make_set_file(sample_mode, sample_freq, clk_edge_mode);

        if isfile(setCustomFile)
            set_file = setCustomFile;
        end
    
        if isfile(setFile)
            disp("<strong>Starting data acquisition...</strong>");
        else
            error("Set file couldn't be found, please check file location is at %s", setFile);
        end
        
        %To capture the 13 signals from a12-a00, and additional port has to be
        %defined (a13-a00), because of SDK malfunction.
       
        [status, cmdout] = system([functionDir, '\SDKCmdUtility.exe s="', char(setFile), '" o="',char(p.Results.saveDirectory), char(p.Results.saveFileName),'" u=o c="a00-a13" b=BIN #=n k=n']);
    end
    [alpha, clk, data_HDR, data_HSNR] = import_gologic_DOG15([char(p.Results.saveDirectory), char(p.Results.saveFileName)],DDR_mode);
end