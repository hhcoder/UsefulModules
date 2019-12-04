FC /L /W %1 %2  > nul
if errorlevel 1 (echo Warning! Refactor Failed!)