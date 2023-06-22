#!/bin/bash

# Define the initial time
hours=0
minutes=0
seconds=0

# Function to format the time
format_time() {
  printf "%02d:%02d:%02d" $hours $minutes $seconds
}

# Function to update the stopwatch
update_stopwatch() {
  ((seconds++))
  if ((seconds == 60)); then
    ((minutes++))
    seconds=0
  fi
  if ((minutes == 60)); then
    ((hours++))
    minutes=0
  fi
}

# Function to start the stopwatch
start_stopwatch() {
  while true; do
    # Update the stopwatch
    update_stopwatch

    # Display the formatted time using yad
    yad --title "Stopwatch" --text "$(format_time)" --width 500 --height 10 --button="Reset:2" --button="Close:0" --timeout 1

    # Check for user input
    if [[ $? -eq 2 ]]; then
      # Reset the stopwatch
      hours=0
      minutes=0
      seconds=0
    elif [[ $? -eq 0 ]]; then
      # Close the stopwatch
      exit
    fi
  done
}

# Start the stopwatch
start_stopwatch
