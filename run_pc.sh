#!/bin/zsh
setopt nullglob

ctrl_c() {
  printf "Cleaning up..."
  rm -f a.out a.txt
  exit
}

trap ctrl_c INT

# Check if the source text file is in the folder
for dir in ./*[cC]/; do
  if [[ -f "$dir/Data.CS.SFSU.txt" ]]; then
    # If it is, check if it has been modified
    if ! cmp -s pc_source_file.txt "$dir/Data.CS.SFSU.txt"; then
      echo "Source text file may have been modified."
      vimdiff -c "set diffopt+=iwhiteall" "$dir/Data.CS.SFSU.txt" pc_source_file.txt
    fi
  fi
done

g++ -std=c++17 -- *[cC]/*.cpp *[cC]/*.h

echo "Attempting to run normally, expecting first line to specify file path"
./a.out < pc_stdin_regular.txt > a.txt
vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
rm a.txt

while true; do
  echo "1: Run without specifying source file path"
  echo "2: Run with student's attached source file"
  echo "3: Run with the source file named \"Data.CS.SFSU.txt\""
  echo "4: Run manually"
  echo "5: Exit"
  echo -n "Select (1-5): "
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
      cp pc_source_file.txt Data.CS.SFSU.txt
      ./a.out < pc_stdin_regular.txt > a.txt
      vimdiff -c "set diffopt+=iwhiteall foldlevel=99999" a.txt pc_stdout.txt
      ;;
    4)
      ./a.out
      ;;
    5)
      break
      ;;
    *)
      echo "Invalid choice. Please select 1, 2, 3, or 4."
      ;;
  esac
done

rm -f a.out a.txt Data.CS.SFSU.txt