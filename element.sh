#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if is a number
#query by atomic number

if [[ $1 =~ ^-?[0-9]+$ ]]; then 

  QUERY_BY_ID=$($PSQL "SELECT * FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = $1") 

# if is query return empity result 
# output erro message 

  if [[ -z $QUERY_BY_ID ]]; then

    echo "I could not find that element in the database."

  else

  #read return from query and output its content

  echo $QUERY_BY_ID | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME IGNORE ATOMIC_MASS MELTING_POINT BOILING_POINT IGNORE TYPE; do



    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $(echo $TYPE | sed -E 's/[0-9][0-9]?\|([a-z]+)/\1/'), with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
 
  done

  fi

  #if is a chemical symbol
  #query by symbol

  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]; then 

  QUERY_BY_SYMBOL=$($PSQL "SELECT * FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.symbol = '$1'")

   if [[ -z $QUERY_BY_SYMBOL ]]; then

    echo "I could not find that element in the database."


    else 

     echo $QUERY_BY_SYMBOL | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME IGNORE ATOMIC_MASS MELTING_POINT BOILING_POINT IGNORE TYPE; do

   echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $(echo $TYPE | sed -E 's/[0-9][0-9]?\|([a-z]+)/\1/'), with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
 
    done

  fi

  elif [[ -z $1 ]]; then

    echo "Please provide an element as an argument."


  else 

      QUERY_BY_NAME=$($PSQL "SELECT * FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.name = '$1'")
      
        if [[ -z $QUERY_BY_NAME ]]; then

            echo "I could not find that element in the database."


        else 

           echo $QUERY_BY_NAME | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME IGNORE ATOMIC_MASS MELTING_POINT BOILING_POINT IGNORE TYPE; do

           echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $(echo $TYPE | sed -E 's/[0-9][0-9]?\|([a-z]+)/\1/'), with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done

  fi


fi



