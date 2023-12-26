#!/bin/bash

lettres="a b c d e f g h i j k l m n o p q r s t u v w x y z"

total=$(wc -l /usr/share/dict/french | cut -f1 -d' ')
echo "total: $total"

for lettre in $lettres; do
  echo -n "$lettre: "
  nb=$(grep ^$lettre /usr/share/dict/french | wc -l)
  p=$(echo "scale=4; $nb / $total * 100" | bc)
  echo -e "$nb   \t- $p%"
done
