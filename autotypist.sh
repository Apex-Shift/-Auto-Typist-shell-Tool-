#!/bin/bash

# --- CONFIGURATION ---
INITIAL_DELAY=3     # Time in seconds to position your cursor
HUMAN_SPEED=0.04    # Base delay between letters in seconds

# 1. Check for required dependencies
if ! command -v xdotool &> /dev/null; then
    zenity --error --title="Error" --text="The 'xdotool' utility is required.\nInstall it using: sudo apt install xdotool"
    exit 1
fi

if ! command -v zenity &> /dev/null; then
    echo "Zenity is not installed. Cannot run in GUI mode."
    exit 1
fi

# 2. Graphical prompt to paste text
ENTERED_TEXT=$(zenity --entry --title="Auto-Typist GUI" --text="Paste or type your text below:" --width=450)

# If the user clicks Cancel or leaves it empty, exit smoothly
if [ -z "$ENTERED_TEXT" ]; then
    exit 0
fi

# 3. Graphical prompt to choose speed mode
SPEED_CHOICE=$(zenity --list --radiolist --title="Speed Settings" \
    --column="Select" --column="Typing Mode" \
    TRUE "TURBO Mode (Ultra-fast)" \
    FALSE "HUMAN Mode (Natural simulation)")

if [ $? -ne 0 ]; then exit 0; fi # Handle Cancel button

# 4. Preparation warning before the countdown
zenity --info --title="Get Ready" --text="After clicking OK, you have $INITIAL_DELAY seconds to click inside your target text field." --width=350

# Visual countdown progress bar
(
for i in $(seq "$INITIAL_DELAY" -1 1); do
    echo "# $i seconds remaining..."
    echo $(( (INITIAL_DELAY - i + 1) * 100 / INITIAL_DELAY ))
    sleep 1
done
) | zenity --progress --title="Attention" --auto-close --width=300 --nocancel

# 5. Execute keystroke simulation
if [[ "$SPEED_CHOICE" == "TURBO Mode"* ]]; then
    # Turbo Mode: Instant full-string drop
    xdotool type --delay 5 "$ENTERED_TEXT"
else
    # Human Mode: Character-by-character loop with random delays
    # FIXED: Correctly types $CHARACTER instead of the full $ENTERED_TEXT string
    for (( i=0; i<${#ENTERED_TEXT}; i++ )); do
        CHARACTER="${ENTERED_TEXT:$i:1}"
        
        # Inject the single character
        xdotool type "$CHARACTER"
        
        # Calculate random natural delay (Speed +/- 0.02s)
        RANDOM_OFFSET=$(awk "BEGIN {srand(); print (rand() * 0.04) - 0.02}")
        DELAY=$(awk "BEGIN {print $HUMAN_SPEED + $RANDOM_OFFSET}")
        
        # Realistic pauses for spaces and punctuation
        if [ "$CHARACTER" == " " ]; then
            DELAY=$(awk "BEGIN {print $DELAY + 0.06}")
        elif [[ "$CHARACTER" =~ [.,!?] ]]; then
            DELAY=$(awk "BEGIN {print $DELAY + 0.25}")
        fi
        
        # Safety limit for minimum execution delay
        if (( $(awk 'BEGIN {print ('$DELAY' < 0.005)}') )); then DELAY=0.005; fi
        
        sleep "$DELAY"
    done
fi

# Completion notification
zenity --info --title="Done" --text="Typing completed successfully!" --width=250
