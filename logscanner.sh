#!/bin/bash

LOG_FILE="$1"

#Make sure we've got an actual file to search through
if [ -z "LOG_FILE" ]; then
  echo "You failed to provide a log. Analysis stopped."
  exit 1
elif [ ! -f "$LOG_FILE" ]; then
  echo "Unable to process, log file not found."
  exit 1
fi

#Let the user know the script is running
echo "[+] Starting log file analysis for $LOG_FILE."

#Searching for errors inside the log file
echo "[+] Errors found: "
grep -Ei "error|critical|fatal" "$LOG_FILE"

#Proviude a count of the errors
echo "[+] Sorted error count: "
awk '{print $NF}' <(grep -Ei "error|critical|fatal" "$LOG_FILE") | sort | uniq -c | sort -rn

#Summary
echo "----------------"
echo "Total errors found: $(grep -Eic "error|critical|fatal" "$LOG_FILE")"
echo "Scan complete. SFMF."