#!/usr/bin/env bash

UNAMEOUT="$(uname -s)"

# Verify operating system is supported...
case "${UNAMEOUT}" in
    Linux*)             MACHINE=linux;;
    Darwin*)            MACHINE=mac;;
    *)                  MACHINE="UNKNOWN"
esac

if [ "$MACHINE" == "UNKNOWN" ]; then
    echo "Unsupported operating system [$(uname -s)]. Laravel Sail supports macOS, Linux, and Windows (WSL2)." >&2

    exit 1
fi

# Determine if stdout is a terminal...
if test -t 1; then
    # Determine if colors are supported...
    ncolors=$(tput colors)

    if test -n "$ncolors" && test "$ncolors" -ge 8; then
        BOLD="$(tput bold)"
        YELLOW="$(tput setaf 3)"
        GREEN="$(tput setaf 2)"
        NC="$(tput sgr0)"
    fi
fi

# Function that prints the available commands...
function display_help {
    echo "Laravel Sail"
    echo
    echo "${YELLOW}Usage:${NC}" >&2
    echo "  sail COMMAND [options] [arguments]"
    echo
    echo "Unknown commands are passed to the docker-compose binary."
    echo
    echo "${YELLOW}docker-compose Commands:${NC}"
    echo "  ${GREEN}sail up${NC}        Start the application"
    echo "  ${GREEN}sail up -d${NC}     Start the application in the background"
    echo "  ${GREEN}sail stop${NC}      Stop the application"
    echo "  ${GREEN}sail restart${NC}   Restart the application"
    echo "  ${GREEN}sail ps${NC}        Display the status of all containers"
    echo
    echo "${YELLOW}Artisan Commands:${NC}"
    echo "  ${GREEN}sail artisan ...${NC}          Run an Artisan command"
    echo "  ${GREEN}sail artisan queue:work${NC}"
    echo
    echo "${YELLOW}PHP Commands:${NC}"
    echo "  ${GREEN}sail php ...${NC}   Run a snippet of PHP code"
    echo "  ${GREEN}sail php -v${NC}"
    echo
    echo "${YELLOW}Composer Commands:${NC}"
    echo "  ${GREEN}sail composer ...${NC}                       Run a Composer command"
    echo "  ${GREEN}sail composer require laravel/sanctum${NC}"
    echo
    echo "${YELLOW}Node Commands:${NC}"
    echo "  ${GREEN}sail node ...${NC}         Run a Node command"
    echo "  ${GREEN}sail node --version${NC}"
    echo
    echo "${YELLOW}NPM Commands:${NC}"
    echo "  ${GREEN}sail npm ...${NC}        Run a npm command"
    echo "  ${GREEN}sail npx${NC}            Run a npx command"
    echo "  ${GREEN}sail npm run prod${NC}"
    echo
    echo "${YELLOW}PNPM Commands:${NC}"
    echo "  ${GREEN}sail pnpm ...${NC}        Run a pnpm command"
    echo "  ${GREEN}sail pnpx${NC}            Run a pnpx command"
    echo "  ${GREEN}sail pnpm run prod${NC}"
    echo
    echo "${YELLOW}Yarn Commands:${NC}"
    echo "  ${GREEN}sail yarn ...${NC}        Run a Yarn command"
    echo "  ${GREEN}sail yarn run prod${NC}"
    echo
    echo "${YELLOW}Bun Commands:${NC}"
    echo "  ${GREEN}sail bun ...${NC}        Run a bun command"
    echo "  ${GREEN}sail bunx${NC}           Run a bunx command"
    echo "  ${GREEN}sail bun run prod${NC}"
    echo
    echo "${YELLOW}Database Commands:${NC}"
    echo "  ${GREEN}sail mysql${NC}     Start a MySQL CLI session within the 'mysql' container"
    echo "  ${GREEN}sail mariadb${NC}   Start a MySQL CLI session within the 'mariadb' container"
    echo "  ${GREEN}sail psql${NC}      Start a PostgreSQL CLI session within the 'pgsql' container"
    echo "  ${GREEN}sail mongodb${NC}   Start a Mongo Shell session within the 'mongodb' container"
    echo "  ${GREEN}sail redis${NC}     Start a Redis CLI session within the 'redis' container"
    echo
    echo "${YELLOW}Debugging:${NC}"
    echo "  ${GREEN}sail debug ...${NC}          Run an Artisan command in debug mode"
    echo "  ${GREEN}sail debug queue:work${NC}"
    echo
    echo "${YELLOW}Running Tests:${NC}"
    echo "  ${GREEN}sail test${NC}          Run the PHPUnit tests via the Artisan test command"
    echo "  ${GREEN}sail phpunit ...${NC}   Run PHPUnit"
    echo "  ${GREEN}sail pest ...${NC}      Run Pest"
    echo "  ${GREEN}sail pint ...${NC}      Run Pint"
    echo "  ${GREEN}sail dusk${NC}          Run the Dusk tests (Requires the laravel/dusk package)"
    echo "  ${GREEN}sail dusk:fails${NC}    Re-run previously failed Dusk tests (Requires the laravel/dusk package)"
    echo
    echo "${YELLOW}Container CLI:${NC}"
    echo "  ${GREEN}sail shell${NC}        Start a shell session within the application container"
    echo "  ${GREEN}sail bash${NC}         Alias for 'sail shell'"
    echo "  ${GREEN}sail root-shell${NC}   Start a root shell session within the application container"
    echo "  ${GREEN}sail root-bash${NC}    Alias for 'sail root-shell'"
    echo "  ${GREEN}sail tinker${NC}       Start a new Laravel Tinker session"
    echo
    echo "${YELLOW}Sharing:${NC}"
    echo "  ${GREEN}sail share${NC}   Share the application publicly via a temporary URL"
    echo "  ${GREEN}sail open${NC}    Open the site in your browser"
    echo
    echo "${YELLOW}Binaries:${NC}"
    echo "  ${GREEN}sail bin ...${NC}   Run Composer binary scripts from the vendor/bin directory"
    echo
    echo "${YELLOW}Customization:${NC}"
    echo "  ${GREEN}sail artisan sail:publish${NC}   Publish the Sail configuration files"
    echo "  ${GREEN}sail build --no-cache${NC}       Rebuild all of the Sail containers"
    echo
    echo "${YELLOW}Custom Commands:${NC}"
    echo "  ${GREEN}sail install${NC}   Install the project dependencies (composer install, key:generate, npm install and npm run build)."
    echo "  ${GREEN}sail up${NC}        Start docker containers in the background"
    echo "  ${GREEN}sail stop${NC}      Terminates started docker containers."
    echo "  ${GREEN}sail force${NC}     Forces commands to be sent directly to docker compose."
    echo "  ${GREEN}sail ds${NC}        Starts the LaraDumps server."
    echo "  ${GREEN}sail stan${NC}      Launch LaraStan Code Checker"
    echo "  ${GREEN}sail myadmin${NC}   Open the PHPMyAdmin administrator."
    echo
    echo "${YELLOW}Custom Commands on GIT:${NC}"
    echo "  ${GREEN}sail commit${NC}   Adds changed and created files and creates commit message."
    echo "  ${GREEN}sail push${NC}     Runs the tests, Laravel Pint and LaraStan, before pushing."

    exit 1
}

# Proxy the "help" command...
if [ $# -gt 0 ]; then
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "-help" ] || [ "$1" == "--help" ]; then
        display_help
    fi
else
    display_help
fi

# Verifica se tem o arquivo .env e ve se quer configurar o sistema

# Source the ".env" file so Laravel's environment variables are available...
# shellcheck source=/dev/null
if [ -n "$APP_ENV" ] && [ -f ./.env."$APP_ENV" ]; then
    source ./.env."$APP_ENV";
elif [ -f ./.env ]; then
    source ./.env;
elif [ -f ./.env.example ]; then
    clear
    echo "${BOLD}No .env configuration file was found in the project, but the example configuration file .env.example was found.${NC}" >&2
    read -p "${BOLD}Want to create a new .env configuration file based on the .env.example file?${NC} (Y/n)" response
    response=${response,,}
    if [[ $response == "y" || $response == "yes" || $response == "" ]]; then
        cp .env.example .env
        echo "" >&2
        read -p "${BOLD}Do you want to run the ${GREEN}sail install${BOLD} command now?${NC} (Y/n)" installingSail
        installingSail=${installingSail,,}
        if [[ $installingSail == "y" || $installingSail == "yes" || $installingSail == "" ]]; then
            export RUN_INSTALLING_SAIL
        else
            echo "" >&2
            echo "${BOLD}Install the project dependencies by running the command: ${GREEN}sail install${NC}" >&2
            exit
        fi
    fi
fi

# Define environment variables...
export APP_PORT=${APP_PORT:-80}
export APP_SERVICE=${APP_SERVICE:-"laravel.test"}
export DB_PORT=${DB_PORT:-3306}
export WWWUSER=${WWWUSER:-$UID}
export WWWGROUP=${WWWGROUP:-$(id -g)}

export SAIL_FILES=${SAIL_FILES:-""}
export SAIL_SHARE_DASHBOARD=${SAIL_SHARE_DASHBOARD:-4040}
export SAIL_SHARE_SERVER_HOST=${SAIL_SHARE_SERVER_HOST:-"laravel-sail.site"}
export SAIL_SHARE_SERVER_PORT=${SAIL_SHARE_SERVER_PORT:-8080}
export SAIL_SHARE_SUBDOMAIN=${SAIL_SHARE_SUBDOMAIN:-""}
export SAIL_SHARE_DOMAIN=${SAIL_SHARE_DOMAIN:-"$SAIL_SHARE_SERVER_HOST"}
export SAIL_SHARE_SERVER=${SAIL_SHARE_SERVER:-""}

# Function that outputs Sail is not running...
function sail_is_not_running {
    echo "${BOLD}Sail is not running.${NC}" >&2
    echo "" >&2
    echo "${BOLD}You may Sail using the following commands:${NC} './vendor/bin/sail up' or './vendor/bin/sail up -d'" >&2

    exit 1
}

# Define Docker Compose command prefix...
if docker compose &> /dev/null; then
    DOCKER_COMPOSE=(docker compose)
else
    DOCKER_COMPOSE=(docker-compose)
fi

if [ -n "$SAIL_FILES" ]; then
    # Convert SAIL_FILES to an array...
    IFS=':' read -ra SAIL_FILES <<< "$SAIL_FILES"

    for FILE in "${SAIL_FILES[@]}"; do
        if [ -f "$FILE" ]; then
            DOCKER_COMPOSE+=(-f "$FILE")
        else
            echo "${BOLD}Unable to find Docker Compose file: '${FILE}'${NC}" >&2

            exit 1
        fi
    done
fi

EXEC="yes"

if [ -z "$SAIL_SKIP_CHECKS" ]; then
    # Ensure that Docker is running...
    if ! docker info > /dev/null 2>&1; then
        echo "${BOLD}Docker is not running.${NC}" >&2

        exit 1
    fi

    # Determine if Sail is currently up...
    if "${DOCKER_COMPOSE[@]}" ps "$APP_SERVICE" 2>&1 | grep 'Exit\|exited'; then
        echo "${BOLD}Shutting down old Sail processes...${NC}" >&2

        "${DOCKER_COMPOSE[@]}" down > /dev/null 2>&1

        EXEC="no"
    elif [ -z "$("${DOCKER_COMPOSE[@]}" ps -q)" ]; then
        EXEC="no"
    fi
fi

ARGS=()

function installingSail {
    if [ "$EXEC" == "no" ]; then
        "${DOCKER_COMPOSE[@]}" up -d
    fi

    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" composer install
    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" php ./artisan key:generate
    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" npm install
    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" npm run build

    if [ "$1" == "up" ]; then
        exit
    elif [ "$EXEC" == "no" ]; then
        "${DOCKER_COMPOSE[@]}" down
    fi
}

lower=${1,,}

if [ -n "$RUN_INSTALLING_SAIL" ]; then
    installingSail
fi

if [ "$lower" == "install" ]; then
    installingSail;
    exit;

elif [ "$lower" == "up" ]; then
    "${DOCKER_COMPOSE[@]}" up -d
    exit

elif [ "$lower" == "stop" ]; then
    "${DOCKER_COMPOSE[@]}" down
    exit

elif [ "$lower" == "force" ]; then
    shift 1

elif [ "$lower" == "ds" ]; then
    if [ "$EXEC" == "yes" ]; then
        "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" php ./artisan ds:init "$(pwd)"
        exit
    else
        sail_is_not_running
    fi

elif [ "$lower" == "stan" ]; then
    shift 1
    if [ "$EXEC" == "yes" ]; then
        "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" php ./vendor/bin/phpstan $@
        exit
    else
        sail_is_not_running
    fi

elif [ "$lower" == "myadmin" ]; then
    shift 1

    if command -v open &>/dev/null; then
        OPEN="open"
    elif command -v xdg-open &>/dev/null; then
        OPEN="xdg-open"
    elif command -v powershell.exe &>/dev/null; then
        OPEN="powershell.exe /C start"
    else
        echo "Neither open nor xdg-open is available. Exiting."
        exit 1
    fi

    if [ "$EXEC" == "yes" ]; then

        if [[ -n "$APP_PORT_MY_ADMIN" && "$APP_PORT_MY_ADMIN" != "8080" ]]; then
            FULL_URL="${APP_URL}:${APP_PORT}"
        else
            FULL_URL="$APP_URL:8080"
        fi

        $OPEN "$FULL_URL"

        exit
    else
        sail_is_not_running
    fi

elif [ "$lower" == "commit" ]; then
    shift 1
    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" php ./vendor/bin/pint;

    git add .

    REGEX_ISSUE_ID="[a-zA-Z0-9,\.\_\-]+-[0-9]+"
    BRANCH_NAME=$(git symbolic-ref --short HEAD)
    ISSUE_ID=$(echo "$BRANCH_NAME" | grep -o -E "$REGEX_ISSUE_ID")
    COMMIT_MESSAGE="$1"

    if [ -z "$ISSUE_ID" ]; then
        echo -e "${BRed}O nome da branch não está no padrão.${NC}"
        exit 1
    fi

    if [[ $COMMIT_MESSAGE == $ISSUE_ID* ]]; then
        NAME_COMMIT="$COMMIT_MESSAGE"
    else
        NAME_COMMIT="$ISSUE_ID: $COMMIT_MESSAGE"
    fi

    git commit -m "${NAME_COMMIT}"
    exit

elif [ "$lower" == "push" ]; then
    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" php ./vendor/bin/phpstan
    if [ $? -ne 0 ]; then
        echo "Erro ao rodar o LaraStan.";
        exit 1;
    fi;

    "${DOCKER_COMPOSE[@]}" exec -u sail "$APP_SERVICE" php artisan test --parallel | php
    if [ $? -ne 0 ]; then
        echo "Erro ao Rodar os tests.";
        exit 1;
    fi;
    
    git push -u origin $(git symbolic-ref --short HEAD)
    exit

# Proxy PHP commands to the "php" binary on the application container...
elif [ "$lower" == "php" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" "php")
    else
        sail_is_not_running
    fi

# Proxy vendor binary commands on the application container...
elif [ "$lower" == "bin" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        CMD=$1
        shift 1
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" ./vendor/bin/"$CMD")
    else
        sail_is_not_running
    fi

# Proxy docker-compose commands to the docker-compose binary on the application container...
elif [ "$lower" == "docker-compose" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" "${DOCKER_COMPOSE[@]}")
    else
        sail_is_not_running
    fi

# Proxy Composer commands to the "composer" binary on the application container...
elif [ "$lower" == "composer" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" "composer")
    else
        sail_is_not_running
    fi

# Proxy Artisan commands to the "artisan" binary on the application container...
elif [ "$lower" == "artisan" ] || [ "$lower" == "art" ] || [ "$lower" == "a" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php artisan)
    else
        sail_is_not_running
    fi

# Proxy the "debug" command to the "php artisan" binary on the application container with xdebug enabled...
elif [ "$lower" == "debug" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail -e XDEBUG_TRIGGER=1)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php artisan)
    else
        sail_is_not_running
    fi

# Proxy the "test" command to the "php artisan test" Artisan command...
elif [ "$lower" == "test" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php artisan test)
    else
        sail_is_not_running
    fi

# Proxy the "phpunit" command to "php vendor/bin/phpunit"...
elif [ "$lower" == "phpunit" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php vendor/bin/phpunit)
    else
        sail_is_not_running
    fi

# Proxy the "pest" command to "php vendor/bin/pest"...
elif [ "$lower" == "pest" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php vendor/bin/pest)
    else
        sail_is_not_running
    fi

# Proxy the "pint" command to "php vendor/bin/pint"...
elif [ "$lower" == "pint" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php vendor/bin/pint)
    else
        sail_is_not_running
    fi

# Proxy the "dusk" command to the "php artisan dusk" Artisan command...
elif [ "$lower" == "dusk" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(-e "APP_URL=http://${APP_SERVICE}")
        ARGS+=(-e "DUSK_DRIVER_URL=http://selenium:4444/wd/hub")
        ARGS+=("$APP_SERVICE" php artisan dusk)
    else
        sail_is_not_running
    fi

# Proxy the "dusk:fails" command to the "php artisan dusk:fails" Artisan command...
elif [ "$lower" == "dusk:fails" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(-e "APP_URL=http://${APP_SERVICE}")
        ARGS+=(-e "DUSK_DRIVER_URL=http://selenium:4444/wd/hub")
        ARGS+=("$APP_SERVICE" php artisan dusk:fails)
    else
        sail_is_not_running
    fi

# Initiate a Laravel Tinker session within the application container...
elif [ "$lower" == "tinker" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" php artisan tinker)
    else
        sail_is_not_running
    fi

# Proxy Node commands to the "node" binary on the application container...
elif [ "$lower" == "node" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" node)
    else
        sail_is_not_running
    fi

# Proxy NPM commands to the "npm" binary on the application container...
elif [ "$lower" == "npm" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" npm)
    else
        sail_is_not_running
    fi

# Proxy NPX commands to the "npx" binary on the application container...
elif [ "$lower" == "npx" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" npx)
    else
        sail_is_not_running
    fi

# Proxy PNPM commands to the "pnpm" binary on the application container...
elif [ "$lower" == "pnpm" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" pnpm)
    else
        sail_is_not_running
    fi

# Proxy PNPX commands to the "pnpx" binary on the application container...
elif [ "$lower" == "pnpx" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" pnpx)
    else
        sail_is_not_running
    fi

# Proxy Yarn commands to the "yarn" binary on the application container...
elif [ "$lower" == "yarn" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" yarn)
    else
        sail_is_not_running
    fi

# Proxy Bun commands to the "bun" binary on the application container...
elif [ "$lower" == "bun" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" bun)
    else
        sail_is_not_running
    fi

# Proxy Bun X commands to the "bunx" binary on the application container...
elif [ "$lower" == "bunx" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" bunx)
    else
        sail_is_not_running
    fi

# Initiate a MySQL CLI terminal session within the "mysql" container...
elif [ "$lower" == "mysql" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(mysql bash -c)
        ARGS+=("MYSQL_PWD=\${MYSQL_PASSWORD} mysql -u \${MYSQL_USER} \${MYSQL_DATABASE}")
    else
        sail_is_not_running
    fi

# Initiate a MySQL CLI terminal session within the "mariadb" container...
elif [ "$lower" == "mariadb" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(mariadb bash -c)
        ARGS+=("MYSQL_PWD=\${MYSQL_PASSWORD} mariadb -u \${MYSQL_USER} \${MYSQL_DATABASE}")
    else
        sail_is_not_running
    fi

# Initiate a PostgreSQL CLI terminal session within the "pgsql" container...
elif [ "$lower" == "psql" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(pgsql bash -c)
        ARGS+=("PGPASSWORD=\${PGPASSWORD} psql -U \${POSTGRES_USER} \${POSTGRES_DB}")
    else
        sail_is_not_running
    fi

# Initiate a Bash shell within the application container...
elif [ "$lower" == "shell" ] || [ "$lower" == "bash" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u sail)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" bash)
    else
        sail_is_not_running
    fi

# Initiate a root user Bash shell within the application container...
elif [ "$lower" == "root-shell" ] || [ "$lower" == "root-bash" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec -u root)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=("$APP_SERVICE" bash)
    else
        sail_is_not_running
    fi

# Initiate a MongoDB Shell within the "mongodb" container...
elif [ "$lower" == "mongodb" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(mongodb mongosh --port "${FORWARD_MONGODB_PORT:-27017}" --username "$MONGODB_USERNAME" --password "$MONGODB_PASSWORD" --authenticationDatabase admin)
    else
        sail_is_not_running
    fi

# Initiate a Redis CLI terminal session within the "redis" container...
elif [ "$lower" == "redis" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        ARGS+=(exec)
        [ ! -t 0 ] && ARGS+=(-T)
        ARGS+=(redis redis-cli)
    else
        sail_is_not_running
    fi

# Share the site...
elif [ "$lower" == "share" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
        docker run --init --rm --add-host=host.docker.internal:host-gateway -p "$SAIL_SHARE_DASHBOARD":4040 -t beyondcodegmbh/expose-server:latest share http://host.docker.internal:"$APP_PORT" \
            --server-host="$SAIL_SHARE_SERVER_HOST" \
            --server-port="$SAIL_SHARE_SERVER_PORT" \
            --auth="$SAIL_SHARE_TOKEN" \
            --server="$SAIL_SHARE_SERVER" \
            --subdomain="$SAIL_SHARE_SUBDOMAIN" \
            --domain="$SAIL_SHARE_DOMAIN" \
            "$@"

        exit
    else
        sail_is_not_running
    fi

# Open the site...
elif [ "$lower" == "open" ]; then
    shift 1

    if command -v open &>/dev/null; then
        OPEN="open"
    elif command -v xdg-open &>/dev/null; then
        OPEN="xdg-open"
    elif command -v powershell.exe &>/dev/null; then
        OPEN="powershell.exe /C start"
    else
        echo "Neither open nor xdg-open is available. Exiting."
        exit 1
    fi

    if [ "$EXEC" == "yes" ]; then

        if [[ -n "$APP_PORT" && "$APP_PORT" != "80" ]]; then
            FULL_URL="${APP_URL}:${APP_PORT}"
        else
            FULL_URL="$APP_URL"
        fi

        $OPEN "$FULL_URL"

        exit
    else
        sail_is_not_running
    fi
fi

# Run Docker Compose with the defined arguments...
"${DOCKER_COMPOSE[@]}" "${ARGS[@]}" "$@"
