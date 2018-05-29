#!/bin/bash

# This script depends on unifdef
# On Ubuntu, run `sudo apt-get install unifdef` to install this

rm -rf out
mkdir out
unifdef -UGET_ARC_INFO -U_CUSTOM_DIAG_HEADER__ collectorCC.c > out/collectorCC.c
cp Makefile.opensource out/Makefile
