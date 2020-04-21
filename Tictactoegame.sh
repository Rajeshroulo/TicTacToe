#!/bin/bash 

ROWS=3
COLMS=3
POS=$(($ROWS*$COLMS))
turns=1
val=""
cmp=""
play=""
position=0
declare -A brd

function tochecktheboard( ) {
for(( i=1; i<=$POS; i++ ))
do
  brd[$i]="-"
done
}

function playervalue( ) {
check=$((1+RANDOM%2))
case $check in
    1 )
       val=x
       cmp=0
       play=player
      ;;
    2 )
       val=0
       cmp=x
       play=computer
      ;;
esac
echo player value is $val
echo computer value is $cmp
echo $play plays first
}

printBoard(){
	echo -e  "\n   Welcome to TicTacToe"
 	echo --------
	for((i=0;i<$ROWS;i++))
	do
		t=$(($COLMS*$i))
		echo  ${brd[$((1+$t))]} \| ${brd[$((2+$t))]} \| ${brd[$((3+$t))]}
		echo ---------
	done
}

checkRows(){
	for((i=0;i<$ROWS;i++))
	do
		r=$((3*$i))
		if [[ ${brd[$((1+$r))]} != "-" &&  ${brd[$((1+$r))]} = ${brd[$((2+$r))]} && ${brd[$((2+$r))]} =  ${brd[$((3+$r))]} ]]
		then
			 echo winner ${brd[$((1+$r))]}
		fi
	done
}

checkColms(){
	for((i=0;i<$COLMS;i++))
	do
		if [[ ${brd[$((1+$i))]} != "-" && ${brd[$((1+$i))]} = ${brd[$((4+$i))]} && ${brd[$((4+$i))]} =  ${brd[$((7+$i))]} ]]
		then
			 echo winner ${brd[$((1+$i))]}
		fi
	done
}

checkDiagonals(){
	if [[ ${brd[1]} != "-" && ${brd[1]} = ${brd[5]} && ${brd[5]} =  ${brd[9]} ]]
	then
		winner ${brd[1]}
	elif [[ ${brd[3]} != - && ${brd[3]} = ${brd[5]} && ${brd[5]} =  ${brd[7]} ]]
	then
		winner ${brd[3]}
	fi

}

checkwinner(){

	if [ $1 = $val ]
	then
		win="player"
	else
		win="computer"
	fi

	printBoard
        echo gameover
	echo Winner is $win
	exit
}
checkTie(){

	if [ $turns -eq $POS ]
	then
		echo game is tie
	fi
}

checkwinOrtie() {

checkRows

checkColms

checkDiagonals

checkTie
checkwinner

}

rows(){
	for((i=0;i<$ROWS;i++))
	do
		t=$((3*$i))

		a=${brd[$((1+$t))]}
		b=${brd[$((2+$t))]}
		c=${brd[$((3+$t))]}

		if [[ $a = $1 && $b = $1 && $c = "-" ]]
		then
			position=$((3+$t))
			break
		elif [[ $b = $1 && $c = $1 && $a = "-" ]]
		then
			position=$((1+$t))
			break
		elif [[ $a = $1 && $c = $1 && $b = "-" ]]
		then
			position=$((2+$t))
			break
		fi
       done
 }

colms(){
	for((i=0;i<$COLMS;i++))
	do
		a=${brd[$((1+$i))]}
		b=${brd[$((4+$i))]}
		c=${brd[$((7+$i))]}

		if [[ $a = $1 && $b = $1 && $c = "-" ]]
		then
			position=$((7+$i))
			break
		elif [[ $b = $1 && $c = $1 && $a = "-" ]]
		then
			position=$((1+$i))
			break
		elif [[ $a = $1 && $c = $1 && $b = "-" ]]
		then
			position=$((4+$i))
			break
		fi
	done
}

diags(){
	for((i=0;i<2;i++))
	do
		t=$((2*$i))
		a=${brd[$((1+$t))]}
		b=${brd[$((5))]}
		c=${brd[$((9-$t))]}

		if [[ $a = $1 && $b = $1 && $c = "-" ]]
		then
			position=$((9-$t))
			break
		elif [[ $b = $1 && $c = $1 && $a = "-" ]]
		then
			position=$((1+$t))
			break
		elif [[ $a = $1 && $c = $1 && $b = "-" ]]
		then
			position=5
			break
		fi
       done
 }

winOrBlock(){
	rows $1
	if [ $position -eq 0 ]
	then
		colms $1
		if [ $position -eq 0 ]
		then
	        	diags $1
		fi
	fi

}

corners(){
	for((i=0;i<2;i++))
	do
		if [ ${brd[$(( 1 + 2*$i ))]} = "-" ]
		then
			position=$(( 1 + 2*$i ))
			break
		elif [ ${brd[$(( 7 + 2*$i ))]} = "-" ]
		then
			position=$(( 7 + 2*$i ))
			break
		fi
	done
}

centre(){
	if [ ${brd[5]} = "-" ]
	then
		position=5
	fi
}

sides(){
	for((i=1;i<4;i++))
	do
		t=$((2*$i))
		if [ ${brd[$t]} = "-" ]
		then
			position=$t
			break
		fi
	done
}

computerTurn(){
	winOrBlock $cmp

	if [ $position -eq 0 ]
	then
		winOrBlock $val
		if [ $position -eq 0 ]
		then
			corners
			if [ $position -eq 0 ]
			then
				centre
			        if [ $position -eq 0 ]
		   		then
					sides
				fi

			fi
		fi
	fi
}

checkValidPosition(){
	if [  ${brd[$1]} != "-" ]
	then
		echo "entered position is already occupied"
		echo "enter your choice"
		valid="false"
	else
		valid="true"
	fi
}


initialize(){
tochecktheboard
playervalue
}

game(){
	while [ $turns -le $POS  ]
	do
		printf "\n"
		if [ $play = computer ]
		then
			echo It is computer turn
			computerTurn
			brd[$position]=$cmp
			((turns++))
			play="player"
		else
			echo It is you turn
			echo "enter your position"
			read position
			checkValidPosition $position
			if [ $valid = true ]
			then
				brd[$position]=$val
				((turns++))
				play="computer"
			fi
		fi

		printBoard
		checkwinOrtie
		position=0

      done
 }

start() {
 initialize
 game
}

start
