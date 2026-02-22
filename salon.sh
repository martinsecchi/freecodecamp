#!/bin/bash
# Salon Appointment Scheduler - freeCodeCamp
# Cumple: listado numérico de servicios, validación de service_id, alta de cliente si no existe por phone,
# toma de hora, inserción en appointments y mensaje final EXACTO.

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

print_header() {
  echo -e "\n~~~~~ MY SALON ~~~~~\n"
  echo "Welcome to My Salon, how can I help you?"
  echo
}

list_services() {
  local services
  services="$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")"
  # Formato: "1) cut"
  echo "$services" | while IFS="|" read -r ID NAME; do
    ID_TRIM=$(echo "$ID" | xargs)
    NAME_TRIM=$(echo "$NAME" | xargs)
    if [[ -n "$ID_TRIM" && -n "$NAME_TRIM" ]]; then
      echo "$ID_TRIM) $NAME_TRIM"
    fi
  done
}

choose_service() {
  # Primera lista
  list_services
  read SERVICE_ID_SELECTED

  # Validación y reintento si no existe
  local service_name
  service_name="$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")"
  service_name=$(echo "$service_name" | xargs)

  while [[ -z "$service_name" ]]; do
    echo
    echo "I could not find that service. What would you like today?"
    list_services
    read SERVICE_ID_SELECTED
    service_name="$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")"
    service_name=$(echo "$service_name" | xargs)
  done

  SERVICE_NAME="$service_name"
}

get_customer() {
  echo
  echo "What's your phone number?"
  read CUSTOMER_PHONE

  local existing_name
  existing_name="$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")"
  existing_name=$(echo "$existing_name" | xargs)

  if [[ -z "$existing_name" ]]; then
    echo
    echo "I don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # Insertar nuevo cliente
    $PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');" >/dev/null
  else
    CUSTOMER_NAME="$existing_name"
  fi

  CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")"
  CUSTOMER_ID=$(echo "$CUSTOMER_ID" | xargs)
}

schedule_appointment() {
  echo
  echo "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # Insertar turno
  $PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');" >/dev/null

  echo
  echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}

main() {
  print_header
  choose_service
  get_customer
  schedule_appointment
  exit 0
}

main