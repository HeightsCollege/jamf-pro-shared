#!/bin/bash

# Credit: Robert Basset (St Gregory's College) for the orignal script.
# Credit: Jonathan McClintock (Heights College) - Modified original script to suit any plugin or file. 

# Path to the system-level TCC database
TCC_DB="/Library/Application Support/com.apple.TCC/TCC.db"

# Linewize / FamilyZone Classroom Plugin Path
TARGET_PATH="/Applications/FamilyZone/MobileZoneAgent/bin/classroom.plugin"

# Default fallback values
RESULT="Not Set"
MODIFIED_DATE="N/A"

# Check if the TCC database exists
if [ -f "$TCC_DB" ]; then
    # Query database for exact path OR any client matching 'classroom.plugin'
    QUERY=$(/usr/bin/sqlite3 "$TCC_DB" "SELECT auth_value, last_modified FROM access WHERE service='kTCCServiceScreenCapture' AND (client='$TARGET_PATH' OR client LIKE '%classroom.plugin%') ORDER BY last_modified DESC LIMIT 1;" 2>/dev/null)

    AUTH_VALUE=$(echo "$QUERY" | awk -F'|' '{print $1}')
    LAST_MODIFIED=$(echo "$QUERY" | awk -F'|' '{print $2}')

    case "$AUTH_VALUE" in
        2)
            RESULT="Enabled"
            ;;
        0)
            RESULT="Denied"
            ;;
        *)
            RESULT="Not Set"
            ;;
    esac

    # Convert Unix timestamp to readable local date
    if [[ "$LAST_MODIFIED" =~ ^[0-9]+$ ]]; then
        MODIFIED_DATE=$(date -r "$LAST_MODIFIED" "+%Y-%m-%d %H:%M:%S")
    fi
else
    RESULT="TCC DB Not Accessible"
fi

# Output formatted for Jamf Pro Inventory
echo "<result>$RESULT (Last Modified: $MODIFIED_DATE)</result>"