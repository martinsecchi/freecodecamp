#!/usr/bin/env bash
# element.sh - FreeCodeCamp Periodic Table Project

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Sin argumentos
if [[ -z "$1" ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

INPUT="$1"

# Detectar tipo de argumento
if [[ "$INPUT" =~ ^[0-9]+$ ]]; then
  COND="e.atomic_number = $INPUT"
elif [[ "$INPUT" =~ ^[A-Za-z]{1,2}$ ]]; then
  SYM="$(echo "$INPUT" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
  COND="e.symbol = '$SYM'"
else
  NAME="$(echo "$INPUT" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
  COND="e.name = '$NAME'"
fi

RESULT="$($PSQL "
SELECT
  e.atomic_number,
  e.name,
  e.symbol,
  t.type,
  p.atomic_mass,
  p.melting_point_celsius,
  p.boiling_point_celsius
FROM elements e
JOIN properties p USING(atomic_number)
JOIN types t USING(type_id)
WHERE $COND
")"

if [[ -z "$RESULT" ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

IFS="|" read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING BOILING <<< "$RESULT"

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."