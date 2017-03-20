#!/bin/bash

# Generalizable option handler

while getopts ":cgh" opt; do
  case ${opt} in
    c ) # process option a
    myOpt=checkURLs
    echo "Check URLs"
      ;;
    g ) # process option l
    myOpt=grepURLs
    echo "Grep URLs"
      ;;
    h ) # process option l
    myOpt=helpMe
    echo "Help me!"
      ;;
    \? ) echo "Usage: cmd [-c] [-g] [-h] <URL file> <optional grep pattern>"
      ;;
  esac
done


URLfile="$2"
grepPattern="$3"
theURLs=( "$(cat $URLfile)" )
delimiter=" : "


# need more error handling!

case "$myOpt" in 

	checkURLs) 
		# process URL header info (http response code)
		for i in ${theURLs[@]}
		do
		echo -n $i $delimiter `curl --progress-bar -I -X GET $i | head -n 1 | cut -d$' ' -f2`
		echo ""
		done
			;;
		
	grepURLs) 
		# process URL grep
		
		#to do: add error for no grep string
		for i in ${theURLs[@]}
		do
		echo -n $i $delimiter `curl --progress-bar -s $i | grep $grepPattern`
		echo ""
		done
	
esac






