#!/bin/bash
 
# Real devs look through the middle of their logs
 
filename=""
lines=10
midline=0
diff=5
startline=5
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
line="$(wc -l $filename | awk '{print $1}')"
echo "Lines: $line"
midline=$(($line >> 1))
echo "Middle line: $midline"
diff=$(($lines >> 1))
echo "Diff: $diff"
startline=$(($midline - $diff))
echo "Start: $startline"

if [[ $lines%2 -eq 1 ]]; then
    endline=$(($midline + $diff + 1))
else
    endline=$(($midline + $diff))
fi
echo "End: $endline"
sed -n ''$startline','$endline'p' $filename
exit 1
