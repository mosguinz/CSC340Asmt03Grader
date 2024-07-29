#!/bin/zsh
setopt nullglob

files=(*[bB]/*.cpp *[bB]/*.h)
g++ -std=c++17 -- "${files[@]}"

./a.out> a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pb_stdout.txt
rm a.out a.txt

# Check for hardcoding fuckery
for f in "${files[@]}"
do
  vim -c "set nomodifiable" "$f"
done