#!/bin/bash
# This script is used to copy all the compiled executables to bin fodler
# Dont modify unless you understand what you are doing.
# Faisal Shahzad
# 2012.12.08

BinDIR="bin/"
CalculateVolumeDIR="CalculateVolume/build/CalculateVolume"
CleanPCDDIR="CleanPCD/build/CleanPCD"
CreateGriddedPCDDIR="CreateGriddedPCD/build/CreateGriddedPCD"
CreateMaxPCDDIR="CreateMaxPCD/build/CreateMaxPCD"
CreateMinPCDDIR="CreateMinPCD/build/CreateMinPCD"
CutFillVolumeDIR="CutFillVolume/build/CutFillVolume"
DiffLiDARDIR="DiffLiDAR/build/DiffLiDAR"

echo "This script is combining all programs" $BinDIR "folder"
echo ""

echo "Copying" $CalculateVolumeDIR " to " $BinDIR "directory."
cp $CalculateVolumeDIR  $BinDIR

echo "Copying" $CleanPCDDIR " to " $BinDIR "directory."
cp $CleanPCDDIR  $BinDIR

echo "Copying" $CreateGriddedPCDDIR " to " $BinDIR "directory."
cp $CreateGriddedPCDDIR  $BinDIR

echo "Copying" $CreateMaxPCDDIR " to " $BinDIR "directory."
cp $CreateMaxPCDDIR  $BinDIR

echo "Copying" $CreateMinPCDDIR " to " $BinDIR "directory."
cp $CreateMinPCDDIR  $BinDIR

echo "Copying" $CutFillVolumeDIR " to " $BinDIR "directory."
cp $CutFillVolumeDIR  $BinDIR

echo "Copying" $DiffLiDARDIR " to " $BinDIR "directory."
cp $DiffLiDARDIR  $BinDIR

echo ""
echo "Finished copying all the programs. Enjoy the ESDReconstructor"
echo ""
echo "fshahzad 2012.12.08"
