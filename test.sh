#!/bin/bash
LOGFILE="/var/log/monitoring.log"
PROCESS_NAME="test"
PROCESS_PATH="/usr/local/bin/test.sh"
TEST_URL="https://test.com/monitoring/test/api"

if ! pgrep -x "$PROCESS_NAME" > /dev/null; then
    echo "$(date): Process $PROCESS_NAME not running. Restarting..." >> $LOGFILE
    $PROCESS_PATH &
elif ! curl -s --head --request GET $TEST_URL | grep "200 OK" > /dev/null; then
    echo "$(date): Process $PROCESS_NAME not responding at $TEST_URL" >> $LOGFILE
fi
