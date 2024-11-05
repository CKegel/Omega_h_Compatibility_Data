#!/bin/bash
csplit -z $1 /Branch/ '{*}'
FirstRunTiming=`grep seconds xx00 | sort | grep -E '[0-9][\.][0-9]+' -o`
SecondRunTiming=`grep seconds xx01 | sort | grep -E '[0-9][\.][0-9]+' -o | tr ' ' '\n'`

PastedOutput=`paste <(echo "$FirstRunTiming") <(echo "$SecondRunTiming") --delimiters ', '`
echo "$PastedOutput"
