#!/bin/bash

# --- CONFIGURATION ---
INITIAL_DELAY=3     # Time in seconds to position your cursor
HUMAN_SPEED=0.04    # Delay between keys in seconds for Human mode

echo "=========================================="
echo "      Auto-Typist Tool (Bash Version)     "
echo "=========================================="

# 1. Check dependencies
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command -v xdotool &> /dev/null; then
        echo "❌ Error: 'xdotool' is required but not installed."
        echo "👉 Install it using: sudo apt install xdotool"
        exit 1
    fi
elif [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This script only supports Linux and macOS."
    exit 1
fi

# 2. Get text from the user
echo "👉 Paste or type the text you want to inject (Press ENTER to confirm):"
read -r ENTERED_TEXT

if [ -z "$ENTERED_TEXT" ]; then
    echo "❌ Error: Text cannot be empty."
    exit 1
fi

# 3. Speed Configuration
echo ""
echo "⚡ Choose your speed mode:"
echo "1) TURBO Mode (Ultra-fast)"
echo "2) HUMAN Mode (Natural speed with random delays)"
read -p "Enter choice [1-2]: " SPEED_CHOICE

# 4. Countdown countdown
echo ""
echo "⏳ Get ready! You have $INITIAL_DELAY seconds to click inside your target text field..."
for i in $(seq "$INITIAL_DELAY" -1 1); do
    echo "$i..."
    sleep 1
done
echo "🚀 Typing started!"

# 5. Typing execution
if [ "$SPEED_CHOICE" == "1" ]; then
    # --- TURBO MODE ---
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # xdotool types the whole string instantly without special char issues
        xdotool type --delay 5 "$ENTERED_TEXT"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS AppleScript system event for fast typing
        osascript -e "tell application \"System Events\" to keystroke \"$ENTERED_TEXT\""
    fi
else
    # --- HUMAN MODE ---
    # Loop through each character of the text
    for (( i=0; i<${#ENTERED_TEXT}; i++ )); do
        CHARACTER="${ENTERED_TEXT:$i:1}"
        
        # Type the single character
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdotool type "$CHARACTER"
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            # Escape quotes for AppleScript
            CLEAN_CHAR=$(echo "$CHARACTER" | sed 's/"/\\"/g')
            osascript -e "tell application \"System Events\" to keystroke \"$CLEAN_CHAR\""
        fi
        
        # Calculate human random delay (Speed +/- 0.02s)
        RANDOM_OFFSET=$(awk "BEGIN {srand(); print (rand() * 0.04) - 0.02}")
        DELAY=$(awk "BEGIN {print $HUMAN_SPEED + $RANDOM_OFFSET}")
        
        # Add extra pause for spaces or punctuation
        if [ "$CHARACTER" == " " ]; then
            DELAY=$(awk "BEGIN {print $DELAY + 0.06}")
        elif [[ "$CHARACTER" =~ [.,!?] ]]; then
            DELAY=$(awk "BEGIN {print $DELAY + 0.25}")
        fi
        
        # Safety minimum delay
        if (( $(awk 'BEGIN {print ('$DELAY' < 0.005)}') )); then DELAY=0.005; fi
        
        sleep "$DELAY"
    done
fi

echo ""
echo "✅ Typing completed successfully!"
