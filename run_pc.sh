#!/bin/zsh
setopt nullglob

# Check if the source text file is in the folder
for dir in ./*[cC]/; do
  if [[ -f "$dir/Data.CS.SFSU.txt" ]]; then
    # If it is, check if it has been modified
    if ! cmp -s Data.CS.SFSU.txt "$dir/Data.CS.SFSU.txt"; then
      echo "Source text file may have been modified."
      vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" "$dir/Data.CS.SFSU.txt" Data.CS.SFSU.txt
    fi
  fi
done

echo "Copying text file to part C folder"
cp Data.CS.SFSU.txt ./*[cC]/

g++ -std=c++17 -- *[cC]/*.cpp *[cC]/*.h

echo "Attempting to run normally, expecting first line to specify file path"
./a.out < pc_stdin_regular.txt > a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
rm a.txt

echo -n "Rerun again without filepath at the start? (y/n) "
read choice
if [ "$choice" = "y" ]; then
  ./a.out < pc_stdin_nofile.txt > a.txt
  vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
fi
rm a.out a.txt