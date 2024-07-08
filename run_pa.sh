#!/bin/zsh
setopt nullglob

g++ -- *[aA]/*.cpp *[aA]/*.h

# No win
echo "Checking no win"
./a.out < pa_stdin_nowin.txt > a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pa_stdout_nowin.txt
rm a.txt

# X win
echo "Checking X win"
./a.out < pa_stdin_xwin.txt > a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pa_stdout_xwin.txt
rm a.out a.txt