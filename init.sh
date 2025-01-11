#!/bin/bash

# Function to detect operating system and set sed in-place flag
set_sed_inplace_flag() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        # macOS/BSD
        SED_INPLACE="-i ''"
    else
        # Linux
        SED_INPLACE="-i"
    fi
}

# Function to prompt the user and ensure input is provided
prompt_required() {
    local prompt_message=$1
    local user_input=""
    while [[ -z "$user_input" ]]; do
        read -p "$prompt_message" user_input
        if [[ -z "$user_input" ]]; then
            echo "This field is required. Please provide a value."
        fi
    done
    echo "$user_input"
}

# Set sed in-place flag based on OS
set_sed_inplace_flag

# Step 1: Get domain
DOMAIN=$(prompt_required "Enter the domain name for your application (e.g., example.com): ")

# Step 2: Get UI user and password
UI_USER=$(prompt_required "Enter the username for the UI login: ")
UI_PASSWORD=$(prompt_required "Enter the password for the UI login: ")

# Step 3: Get SMTP user and password
SMTP_USER=$(prompt_required "Enter the username for the SMTP service: ")
SMTP_PASSWORD=$(prompt_required "Enter the password for the SMTP service: ")

# Step 4: Update Caddyfile
if [[ -f "Caddyfile" ]]; then
    eval sed $SED_INPLACE "s/DOMAIN/$DOMAIN/g" Caddyfile
    echo "Updated the Caddyfile with the domain: $DOMAIN"
else
    echo "Caddyfile not found. Please ensure it exists in the current directory."
fi

# Step 5: Rewrite ui-auth file
if [[ -f "ui-auth" ]]; then
    echo "$UI_USER:$UI_PASSWORD" > ui-auth
    echo "Updated the ui-auth file with the UI credentials."
else
    echo "ui-auth file not found. Please ensure it exists in the current directory."
fi

# Step 6: Rewrite smtp-auth file
if [[ -f "smtp-auth" ]]; then
    echo "$SMTP_USER:$SMTP_PASSWORD" > smtp-auth
    echo "Updated the smtp-auth file with the SMTP credentials."
else
    echo "smtp-auth file not found. Please ensure it exists in the current directory."
fi

# Step 7: Update docker-compose.yml
if [[ -f "docker-compose.yml" ]]; then
    eval sed $SED_INPLACE "s/DOMAIN/$DOMAIN/g" docker-compose.yml
    echo "Updated the docker-compose.yml file with the domain: $DOMAIN"
else
    echo "docker-compose.yml file not found. Please ensure it exists in the current directory."
fi

echo "All configurations have been updated successfully!"