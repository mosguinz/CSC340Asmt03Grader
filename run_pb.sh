#!/bin/zsh
setopt nullglob

g++ -std=c++17 -- *[bB]/*.cpp *[bB]/*.h

./a.out> a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pb_stdout.txt
rm a.out a.txt
