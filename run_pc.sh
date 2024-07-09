#!/bin/zsh
setopt nullglob

# Check if the source text file is in the folder
for dir in ./*[cC]/; do
  if [[ -f "$dir/Data.CS.SFSU.txt" ]]; then
    # If it is, check if it has been modified
    if ! cmp -s pc_source_file.txt "$dir/Data.CS.SFSU.txt"; then
      echo "Source text file may have been modified."
      vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" "$dir/Data.CS.SFSU.txt" pc_source_file.txt
    fi
  fi
done

echo "Copying text file to part C folder"
cp pc_source_file.txt ./*[cC]/

g++ -std=c++17 -- *[cC]/*.cpp *[cC]/*.h

echo "Attempting to run normally, expecting first line to specify file path"
./a.out < pc_stdin_regular.txt > a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
rm a.txt

while true; do
  echo "1: Run again without file path"
  echo "2: Run again with original source file"
  echo "3: Run again manually"
  echo "4: Exit"
  echo -n "Select (1-4): "
  read choice

  case $choice in
    1)
      ./a.out < pc_stdin_nofile.txt > a.txt
      vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
      rm a.txt
      ;;
    2)
      (echo ./*[cC]/Data.CS.SFSU.txt && cat pc_stdin_nofile.txt) | ./a.out > a.txt
      vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
      ;;
    3)
      ./a.out
      ;;
    4)
      break
      ;;
    *)
      echo "Invalid choice. Please select 1, 2, 3, or 4."
      ;;
  esac
done

rm a.out a.txt