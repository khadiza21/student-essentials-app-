#!/bin/bash
# Function to calculate the result based on user input
calculate_result() {
  local input=$1
  local result=$(bc <<< "$input")
  echo "$result"
}

# Show the calculator dialog using yad
while true; do
  # Prompt the user to enter an expression
  expression=$(yad --title "Calculator" --text "Enter an expression:" --entry --width 300)

  # Check if the user clicked the cancel button or closed the window
  if [[ $? -ne 0 ]]; then
    exit
  fi

  # Check if the expression is empty
  if [[ -z "$expression" ]]; then
    yad --title "Error" --text "Expression cannot be empty!" --width 200 --height 100 --button="OK:0"
    continue
  fi

  # Calculate the result
  result=$(calculate_result "$expression")

  # Check if the calculation failed
  if [[ $? -ne 0 ]]; then
    yad --title "Error" --text "Invalid expression!" --width 200 --height 100 --button="OK:0"
    continue
  fi

  # Show the result to the user
  yad --title "Result" --text "Result: $result" --width 200 --height 100 --button="OK:0"
done
