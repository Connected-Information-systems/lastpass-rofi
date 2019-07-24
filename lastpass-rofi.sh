#!/bin/bash
REQUIRED_TOOLS="xclip rofi dmenu lpass"

usage() {
    echo "USAGE: "
    echo ""
    echo "$0 EMAILADDRESS [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "     -t --timeout <HOURS>"
    echo "        Sets lastpass client session duration. Default value is 1 hour"
    echo "     -m --mode    <MODE>"
    echo "        Sets the copy mode [username, password, url, notes] (Defaults to password)."
}

# Check for required tools
for TOOL in $REQUIRED_TOOLS; do
    if ! [ -x "$(command -v "$TOOL")" ]; then
        echo "Tool not found: '$TOOL'"
        exit 1
    fi
done

while [ "$1" != "" ]; do
case $1 in
        -h|--help )    shift
                       usage; exit 0
                       ;;
        -t|--timeout ) shift
                       TIMEOUT=$1
                       ;;
        -m|--mode)     shift
                       MODE=$1
                       ;;
        * )            EMAIL=$1
    esac
    shift
done

if [ -z "$EMAIL" ]; then
    echo "Mandatory argument missing"
    echo ""
    usage
    exit 1
fi

if [ -n "$TIMEOUT" ]; then
    (( timeout_in_seconds=TIMEOUT * 60 * 60 ))
    export LPASS_AGENT_TIMEOUT=$timeout_in_seconds
fi

if [ -z "$MODE" ]; then
    MODE="password"
else
    if [ $MODE != 'password' ] && [ $MODE != 'username' ] && [ $MODE != 'url' ] && [ $MODE != 'notes' ]; then
        echo "Mode parameter is not correct"
        echo ""
        usage
        exit 1
    fi
fi

status="$(lpass status)"

if [ "$status" = "Not logged in." ]; then
    lpass login "$EMAIL"
fi

line=$(lpass ls -l | cut -c 18- | rofi -dmenu -i -p "Select the $MODE to copy" "$@")

if [ -n "$line" ]; then
    pass_id=$(echo "$line" | grep -Po '\[id: ([0-9]*)' | cut -d ' ' -f 2)
    echo -n "$(lpass show "$pass_id" --$MODE)" | xclip -selection clipboard
fi
