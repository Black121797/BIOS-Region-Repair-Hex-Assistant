@echo off
title BIOS Region Repair & Hex Editing Assistant
mode con: cols=90 lines=32

:MENU
cls
echo ==================================================================================
echo                  BIOS REGION REPAIR & HEX EDITING ASSISTANT
echo ==================================================================================
echo  Select an option to lookup offsets or check image headers:
echo ==================================================================================
echo  1. Intel ME/CSME Region Common Hex Headers (HxD Cheat Sheet)
echo  2. Query Board Platform Flash Layouts (Lenovo, ASUS, Acer)
echo  3. Simulate ME Region Integrity Check
echo  4. Exit Assistant
echo ==================================================================================
set /p choice="Enter selection (1-4): "

if "%choice%"=="1" goto HEADERS
if "%choice%"=="2" goto PLATFORMS
if "%choice%"=="3" goto SIMULATE
if "%choice%"=="4" exit
goto MENU

:HEADERS
cls
echo ==================================================================================
echo                    COMMON INTEL ME / FIRMWARE HEX HEADERS
echo ==================================================================================
echo  Use these hex string patterns inside your Hex Editor (like HxD) to find regions:
echo ----------------------------------------------------------------------------------
echo  [+] Descriptors Region ($FPT)       -^> Search Hex: 24 46 50 54
echo  [+] Intel ME VSCC Table             -^> Search Hex: 24 56 53 43
echo  [+] Intel ME Kernel Execution (MFS) -^> Search Hex: 24 4d 46 53
echo  [+] Dell DMI/Serial Data Blocks     -^> Search ASCII: "Service Tag" or "SVCTAG"
echo ----------------------------------------------------------------------------------
echo  Tech Note: When cleaning an ME Region, paste write the clean bin payload starting
echo  one offset block above the $FPT header to preserve structural sizing.
echo ----------------------------------------------------------------------------------
pause
goto MENU

:PLATFORMS
cls
echo ==================================================================================
echo                     MOTHERBOARD BIOS ARCHITECTURE PROFILES
echo ==================================================================================
echo  Select a board platform profile to check structure sizes:
echo  1. ASUS X455LAB Series (8MB Dump)
echo  2. Acer Nitro 5 GH51G (16MB Dump)
echo  3. Return to Main Menu
echo ----------------------------------------------------------------------------------
set /p board="Select option (1-3): "

if "%board%"=="1" (
    echo.
    echo [!] Platform: ASUS X455LAB Main ROM
    echo [i] Expected Chip Size: 8,388,608 bytes (8MB SPI Flash)
    echo [i] Typical ME Version: Intel ME v10.x Series
    echo [i] Diagnostic: If laptop has a 30-second delay before display, clean this ME block.
)
if "%board%"=="2" (
    echo.
    echo [!] Platform: Acer Nitro 5 (GH51G LA-L181P)
    echo [i] Expected Chip Size: 16,777,216 bytes (16MB SPI Flash)
    echo [i] Typical ME Version: Intel CSME v14.x Series
    echo [i] Diagnostic: Ensure PCH tracking logic is reset using clean system descriptors.
)
pause
goto MENU

:SIMULATE
cls
echo ==================================================================================
echo                      ME REGION INTEGRITY SIMULATION LOOP
echo ==================================================================================
echo  [i] Simulating an analysis of 'backup_dump.bin'...
echo  Searching for Descriptor signature map...
timeout /t 1 >nul
echo  [+] Found $FPT Header at offset: 0x00001000
echo  Checking ME firmware state registry...
timeout /t 1 >nul
echo  [WARNING] ME Region state flag is marked: "Initialized / Corrupted"
echo  [Symptom Risk] Slow fan spinning, auto-shutdown loops, or 15+ second post lag.
echo ----------------------------------------------------------------------------------
echo  [Action Plan] Extract the BIOS region, stitch a clean system repository image,
echo  and use your CH341A flasher to rewrite the chip structure cleanly.
echo ----------------------------------------------------------------------------------
pause
goto MENU
