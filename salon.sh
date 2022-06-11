#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# do not trunate services
#TRUNCATE=$($PSQL "TRUNCATE customers, appointments")

echo -e "\n~~~~ Welcome to My Salon ~~~~\n"

SERVICE_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "Hello, how can I help you?"
  echo -e "\n1) Cut\n2) Dye\n3) Style \n4) Trim"
  read SERVICE_ID

  # Looks up input for service id and assigns it matching service_id from services
  SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services where service_id = '$SERVICE_ID'")
  echo $SERVICE_ID_SELECTED

  # if invalid input
    if [[ -z $SERVICE_ID_SELECTED ]]
    then
      # send back to service menu with message
      SERVICE_MENU "Sorry, we do not offer that here.\n Please select a number that corresponds to a service you would like to book.\n"

    else
    # SERVICE_ID_SELECTED exists
    # ask for phone number to look up customer
    echo "What is your phone number?"
    read RECEIVED_PHONE

    # see if number exists
    CUSTOMER_PHONE=$($PSQL "SELECT phone FROM customers WHERE phone ='$RECEIVED_PHONE'")

    if [[ -z $CUSTOMER_PHONE ]]
    then
      echo "Sorry, we do not have a record of you, What is your name?"
      read CUSTOMER_NAME

      # insert customer_name, customer_phone
      INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$RECEIVED_PHONE')")
      # set CUSTOMER_PHONE
    fi

    # Retrieve customer_id, name and phone from select statement
    read -r CUSTOMER_ID BAR CUSTOMER_NAME BAR CUSTOMER_PHONE <<<$(echo $($PSQL "SELECT customer_id, name, phone FROM customers WHERE phone='$RECEIVED_PHONE'"))
    echo "$CUSTOMER_ID $CUSTOMER_NAME $CUSTOMER_PHONE"
    
    # 
  fi
}







SERVICE_MENU