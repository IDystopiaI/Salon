#!/bin/bash


# TRUNCATE = $($PSQL "TRUNCATE customers, appointments")
# do not truncte services

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~ Welcome to My Salon ~~~~\n"

# Main menu fucntion
SERVICE_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "Hello, how can I help you?"
  echo -e "\n1) Cut\n2) Dye\n3) Style \n4) Trim"
  read SERVICE_ID


  SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE service_id = '$SERVICE_ID'")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID'")

# check value of $SERVICE_RESPONSE
# handle unsupported input(wrong type of input or out of range)
if [[ -z $SERVICE_ID_SELECTED ]]
then
  SERVICE_MENU "Sorry, we do not offer that here. \nPlease select a number that corresponds to a service you would like to book.\n"
else

# ask for phone number
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE

  # fetch client id using phone number
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    
  # # if does not exist in customers table
  if [[ -z $CUSTOMER_ID ]]
  then
  # ask for name
    echo -e "I don't have a record of that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert phone number and name
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
      CUSTOMER_DETAILS=$($PSQL "SELECT customer_id, name, phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    echo "$CUSTOMER_DETAILS" | while read CUSTOMER_ID BAR CUSTOMER_NAME BAR CUSTOMER_PHONE
    do
    # trim white space
      echo -e "\nWhat time would you like to book your $SERVICE_NAME, $CUSTOMER_NAME?"
    done
  read SERVICE_TIME
  # trim white space
  echo "I have you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME"
# create booking
  # ask what time they would like their $SERVICE
  # echo I have you booked for $SERVICE at $TIME, $CNAME
fi
}

SERVICE_MENU