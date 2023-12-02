#!/usr/bin/env bash
set -e

cat << "EOF"
 __        __   _  __     ___      _    ____ _                 _ 
 \ \      / /__| |_\ \   / (_)_ __| |_ / ___| | ___  _   _  __| |
  \ \ /\ / / _ \ '_ \ \ / /| | '__| __| |   | |/ _ \| | | |/ _` |
   \ V  V /  __/ |_) \ V / | | |  | |_| |___| | (_) | |_| | (_| |
    \_/\_/ \___|_.__/ \_/  |_|_|   \__|\____|_|\___/ \__,_|\__,_|

EOF

# Start docker compose
function start_webvirtcloud() {
    ININT_DB=false

    # Check if custom.env exists
    if [ ! -f custom.env ]; then
        echo "File custom.env not found!"
        echo -e "\nRun '$0 env' first\n"
        exit 1
    fi

    # Check if .mysql directory exists
    if [ ! -d ".mysql" ]; then
        ININT_DB=true
    fi

    echo "Start WebVirtCloud..."
    docker compose build --no-cache
    docker compose up -d
    
    # Init database
    if [ "$ININT_DB" = true ]; then
        docker compose exec backend python manage.py migrate
        docker compose exec backend python manage.py loaddata initial_data
    fi
}

# Restart docker compose
function stop_webvirtcloud() {
    echo "Restarting WebVirtCloud..."
    docker compose restart
}

# Stop docker compose
function stop_webvirtcloud() {
    echo "Stop WebVirtCloud..."
    docker compose down
}

# Pull latest changes
function git_pull() {
    echo "Pulling latest changes..."
    git pull
}

# Add base domain to custom.env
function add_to_custom_env() {
    echo -e "Enter your wildcard domain. Example: webvirt.local"
    read -p "Enter: " domain_name
    echo "BASE_DOMAIN=${domain_name}" > custom.env
    echo "API_DOMAIN=api.${domain_name}" >> custom.env
    echo "ASSETS_DOMAIN=assets.${domain_name}" >> custom.env
    echo "CLIENT_DOMAIN=client.${domain_name}" >> custom.env
    echo "CONSOLE_DOMAIN=console.${domain_name}" >> custom.env
    echo -e "\nWildcard domain: "${domain_name}" added to custom.env\n"
}

# Show help function
function show_help() {
cat << "EOF"
Available commands:

env             Configure custom.env
start           Start WebVirtCloud
restart         Restart WebVirtCloud
stop            Stop WebVirtCloud
update          Update WebVirtCloud
help            Show this message

EOF
}

# Check if docker installed
if ! command -v docker &> /dev/null; then
    echo -e "\nDocker not found! Please install docker first\n"
    exit 1
fi

# Run functions
case "$1" in
    "help")
        show_help
        ;;
    "env")
        add_to_custom_env
        ;;
    "start")
        start_webvirtcloud
        ;;
    "stop")
        stop_webvirtcloud
        ;;
    "update")
        stop_webvirtcloud
        git_pull
        start_webvirtcloud
        ;;
    "restart")
        restart_webvirtcloud
        ;;
    *)
        echo "No command found."
        echo
        show_help
        ;;
esac
