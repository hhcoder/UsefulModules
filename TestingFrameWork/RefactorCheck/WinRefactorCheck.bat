@echo off
COPY ..\..\Development\CmdLineTest\Debug\DualPdCmdLineTest.exe .\ > nul
COPY ..\..\Development\CoreLib\out\Debug\DualPdLib.lib .\ > nul
@ECHO Y | DEL OUTPUT\*.*
.\DualPdCmdLineTest.exe .\input\pdaf_input_lens_pos_860_config.txt	 > nul
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_calib.txt .\output\pdaf_input_lens_pos_860_calib.txt
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_classify.txt .\output\pdaf_input_lens_pos_860_classify.txt
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_grid_info.txt .\output\pdaf_input_lens_pos_860_grid_info.txt
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_result.txt .\output\pdaf_input_lens_pos_860_result.txt
