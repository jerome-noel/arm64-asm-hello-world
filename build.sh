#!/bin/zsh

as hello.s -o hello.o
ld hello.o -o hello -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
