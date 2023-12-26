#!/bin/bash
# https://www.le-dictionnaire.com/definition/constitution
# https://www.synonymes.com/synonyme.php?mot=herbe

fr_words=$(cat /usr/share/dict/french)
en_words=$(cat /usr/share/dict/american-english)
dicodir="."

testword="personne"

rmhtml="sed \"s/<[^>]*>//g\""

echo ".TH $testword 1 $testword\-1.0" > $dicodir/$testword.1

sed -n -e "/.*defbox.*/,/^ *<\/div>$/ p" $testword \
  | sed "s/.*extraboxinfo.*/.SH/g"                 \
  | sed "s/.*defbox.*/.SH/g"                       \
  | sed "s/.*motboxinfo\">/.I\n/g"                 \
  | sed "s/.*<li>/.P\n- /g"                        \
  | sed "s/<[^>]*>//g"                             \
  | sed "s/^ *//g"                                 \
  | sed "/^$/d"

# get only defbox divs
# extra box info title
# definition title
# definition info: genre, pluriel...
# def liste
# rm html balise
# rm wild indentation
# rm empty line

#| sed "s/^ *//g" | sed "/^$testword.*$/Ii .TR"
