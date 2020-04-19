#!/bin/bash 

declare -a arr

function tochecktheboard( ) {
for(( i=0; i<9; i++ ))
do
  arr[i]=n
done
echo the board is in the form ${arr[@]}
}

function playervalue( ) {
check=$((1+RANDOM%2))
case $check in
    1 )
       value=x
      ;;
    2 )
       value=0
      ;;
esac
echo player value is $value
}

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

tochecktheboard

playervalue

player=x
computer=0
if [ $player=$value ]
then
    echo player wins the game
elif [ $computer=$value ]
then
    echo computer wins the game
else
    echo the game is tie
fi


