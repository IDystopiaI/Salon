#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~ Welcome to My Salon ~~~~\n"

# Main menu fucntion
  # case statement "what can I do for you" (serice options)
SERVICE_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "Hello, how can I help you?"
  echo -e "\n1) Cut\n2) Dye\n3) Style \n4) Trim"
  read MENU_RESPONSE


  SERVICE_RESULT=$($PSQL "SELECT * FROM services WHERE service_id = '$MENU_RESPONSE'")
  echo $SERVICE_RESULT

# check value of $SERVICE_RESPONSE
if [[ -z $SERVICE_RESULT ]]
then
  SERVICE_MENU "Sorry, we do not offer that here.\nPlease select a number that corresponds \nto a service you would like to book.\n"
else
  echo $SERVICE_RESPONSE
fi
}

# handle unsupported input(wrong type of input or out of range)



# ask for phone number
  # fetch client id using phone number
  # if does not exist in customers table
  # ask for name
  # insert phone number and name

  # handle bad input?


# create booking
  # ask what time they would like their $SERVICE
  # echo I have you booked for $SERVICE at $TIME, $CNAME

  SERVICE_MENU