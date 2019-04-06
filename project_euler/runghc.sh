#! /bin/bash

target=$1
ghc --make ${target} -o out.exe -outputdir /tmp
./out.exe
rm -f out.exe

