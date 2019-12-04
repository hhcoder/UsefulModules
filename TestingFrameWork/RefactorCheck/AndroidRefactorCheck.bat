@echo off
CALL RunAndroid.bat > nul
@ECHO Y | DEL OUTPUT\*.*
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_calib.txt .\android_output\pdaf_input_lens_pos_860_calib.txt
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_classify.txt .\android_output\pdaf_input_lens_pos_860_classify.txt
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_grid_info.txt .\android_output\pdaf_input_lens_pos_860_grid_info.txt
CALL COMPARE.BAT .\standard\pdaf_input_lens_pos_860_result.txt .\android_output\pdaf_input_lens_pos_860_result.txt
pause
