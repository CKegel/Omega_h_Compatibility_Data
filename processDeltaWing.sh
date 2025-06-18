#!/bin/bash
csplit -z -s $1 /Branch/ '{*}'
FirstRunTiming=`grep seconds xx00 | sed -E 's/ took /,/' | sed 's/ seconds//'`
SecondRunTiming=`grep seconds xx01 | grep -E '[0-9][\.][0-9]+' -o | tr ' ' '\n'`

PastedOutput=`paste <(printf "$FirstRunTiming") <(printf "$SecondRunTiming") --delimiters ','`
echo "Operation,FirstRunTiming,SecondRunTiming,"
echo "$PastedOutput"
