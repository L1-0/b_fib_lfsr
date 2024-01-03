@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM /// lfsr_fib in Windows Batch ported from a C example as a proof of concept https://en.wikipedia.org/wiki/Linear-feedback_shift_register
REM /// cycleCount is always 65535

SET /A initialState=0xACE1
SET /A registerValue=!initialState!
SET /A cycleCount=0

:LOOP

    REM Extract individual bits
    SET /A "bit0=!registerValue! ^& 1"
    SET /A "bit2=^(!registerValue! >> 2^) ^& 1"
    SET /A "bit3=^(!registerValue! >> 3^) ^& 1"
    SET /A "bit5=^(!registerValue! >> 5^) ^& 1"
    
    REM XOR operation
    SET /A "xorBit2and3=!bit2! ^^ !bit3!"
    SET /A "xorBit0and5=!bit0! ^^ !bit5!"
    SET /A "generatedBit=!xorBit2and3! ^^ !xorBit0and5!"

    REM Shift and insert the bit
    SET /A "registerValue=^(!registerValue! >> 1^) | ^(!generatedBit! << 15^)"

    SET /A "cycleCount+=1"

    REM Check for initial state
    IF !registerValue! EQU !initialState! GOTO :ENDLOOP
    TITLE !registerValue! / !initialState! / !cycleCount!

    GOTO :LOOP

:ENDLOOP
ECHO.Cycle Count: !cycleCount!

ENDLOCAL
