#!/bin/bash 

declare -a arr

for(( i=0; i<9; i++ ))
do
  arr[i]=n
done

check=$((1+RANDOM%2))
case $check in
    1 )
       value=x
      ;;
    2 )
       value=0
      ;;
esac

toss=$((RANDOM%2))
case $toss in
   0 )
      play=computer
     ;;
   1 )
      play=player
     ;;
esac
echo $play plays first


