#!/bin/bash 

play=0

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
       val=x
       play=player
      ;;
    2 )
       val=0
       play=computer
      ;;
esac
echo player value is $val
echo $play plays first

if [ $val=x ]
then
    cmp=0
elif [ $val=0 ]
then
    cmp=x
else
  echo invalid
fi
echo computer value is $cmp
}

playervalue

player=x
computer=0
if [ $player=$val ]
then
    echo player wins the game
elif [ $computer=$val ]
then
    echo computer wins the game
else
    echo the game is tie
fi

for(( i=0; i<9; i++ ))
do
   if(( arr[0]=$val && arr[1]=$val && arr[2]=$val ))
    then
        echo player wins
   elif(( arr[0]=$cmp && arr[1]=$cmp && arr[2]=$cmp ))
     then
        echo computer wins
   else
      echo game is tied
   fi
done

