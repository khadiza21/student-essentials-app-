#!/bin/bash

# Function to perform arithmetic calculations
perform_calculation() {
    local numbers=("$@")  # Store the input numbers in an array
    local operator=$1
    local result

    case $operator in
        +)
            result=$(IFS="+"; echo "${numbers[*]}" | bc)
            ;;
        -)
            result=$(IFS="-"; echo "${numbers[*]}" | bc)
            ;;
        *)
            echo "Invalid operator"
            return
            ;;
    esac

    echo "Result: $result"
}

# Function to calculate BMI
calculate_bmi() {
    local weight=$1
    local height=$2

    bmi=$(echo "scale=2; $weight / (($height/100) * ($height/100))" | bc)
    echo "BMI: $bmi"
}

# Prompt the user to enter numbers and perform calculations
while true; do
    read -p "Enter numbers (space-separated) or 'q' to quit: " input

    if [[ $input == "q" ]]; then
        echo "Calculator exited."
        exit
    fi

    # Split the input into an array of numbers and operator
    IFS=" " read -r -a tokens <<< "$input"

    if [[ ${tokens[0]} == "bmi" ]]; then
        # Calculate BMI
        if [[ ${#tokens[@]} -ne 3 ]]; then
            echo "Invalid input for BMI calculation. Enter weight and height."
        else
            calculate_bmi "${tokens[1]}" "${tokens[2]}"
        fi
    else
        # Perform arithmetic calculation
        perform_calculation "${tokens[@]}"
    fi
done

