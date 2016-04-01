#!/bin/bash
 
# Real devs look through the middle of their logs
 
filename=""
lines=10
midline=0
while getopts ":n:" opt; do
    case $opt in
        n)
          re='^[0-9]+$'
          if ! [[ $OPTARG =~ $re ]] ; then
              echo "Option -n requires a numeric argument"
              exit 1
          fi
          lines=$(($OPTARG - 1))
          #echo "Lines = $lines"
          ;;
        :)
          echo "Option -$OPTARG requires an argument."
          exit 1
          ;;
    esac
done
 
for i in $@; do :; done
filename=$i
#echo "Filename is $filename"
midline="$(wc -l $filename | awk '{print $1}')"
#echo "Midline = $midline"
midline=$(($midline / 2))
#echo "Midline = $midline"
endline=$(($midline + $lines))
sed -n ''$midline','$endline'p' $filename
exit 1
