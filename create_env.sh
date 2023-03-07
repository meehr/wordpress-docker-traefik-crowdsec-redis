#!/bin/bash

# Frag nach dem Pfad zur Docker-Compose-Datei
read -p "Gib den Pfad zur Docker-Compose-Datei ein: " COMPOSE_FILE_PATH

# Setze das Verzeichnis der Docker-Compose-Datei als Arbeitsverzeichnis
cd "$(dirname "$COMPOSE_FILE_PATH")"

# Extrahiere Variablen aus der Docker-Compose-Datei
VARIABLES=$(grep -oP '\$\{.*?\}' "$(basename "$COMPOSE_FILE_PATH")" | sort | uniq)

# Erstelle die .env-Datei, wenn sie nicht vorhanden ist
touch .env

# Schreibe vorhandene Variablen in die .env-Datei
for VARIABLE in $VARIABLES
do
    # Extrahiere den Variablennamen und den Standardwert (falls vorhanden) aus dem Format ${NAME:-DEFAULT_VALUE}
    VARIABLE_NAME=$(echo "$VARIABLE" | cut -d':' -f1 | cut -d'{' -f2 | tr -d '}')
    VARIABLE_DEFAULT_VALUE=$(echo "$VARIABLE" | cut -d':' -f2 | cut -d'}' -f1)

    # Überprüfe, ob die Variable bereits in der .env-Datei vorhanden ist
    if grep -q "^$VARIABLE_NAME=" .env; then
        echo "Die Variable '$VARIABLE_NAME' existiert bereits in der .env-Datei"
    else
        # Schreibe die Variable in die .env-Datei
        if [ -n "$VARIABLE_DEFAULT_VALUE" ]; then
            read -p "Gib einen Wert für die Variable '$VARIABLE_NAME' ein (Standardwert: $VARIABLE_DEFAULT_VALUE): " VARIABLE_VALUE
            echo "$VARIABLE_NAME=${VARIABLE_VALUE:-$VARIABLE_DEFAULT_VALUE}" >> .env
        else
            read -p "Gib einen Wert für die Variable '$VARIABLE_NAME' ein: " VARIABLE_VALUE
            echo "$VARIABLE_NAME=$VARIABLE_VALUE" >> .env
        fi
    fi
done

echo "Alle Variablen wurden in die .env-Datei geschrieben"
