#!/bin/zsh
setopt nullglob

files=(*[aA]/*.cpp *[aA]/*.h)
g++ -std=c++17 -- "${files[@]}"

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

# Check for hardcoding fuckery
for f in "${files[@]}"
do
  vim -c "set nomodifiable" "$f"
done