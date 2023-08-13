#!/data/data/com.termux/files/usr/bin/bash

# Store the original volume level
ORIGINAL_VOLUME=$(termux-volume | jq -r '.[] | select(.stream == "music") | .volume')

# Loop to read notifications
while true; do
    # Read the latest notification
    NOTIFICATION=$(termux-notification-list | jq -r '.[] | select(.packageName == "com.spotify.lite") | .title')

    # Check if notification contains "Advertisement" in title
    if echo "$NOTIFICATION" | grep -q "Advertisement"; then
        # Lower media volume
        termux-volume music 0
    else
        # Restore original volume
        termux-volume music "$ORIGINAL_VOLUME"
    fi

    # Delay before checking again
    sleep 5
done