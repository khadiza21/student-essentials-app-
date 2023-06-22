#!/bin/bash

# Function to perform addition
#!/bin/bash

# Function to calculate the sum of numbers
addition() {
    local numbers=("$@")  # Store the input numbers in an array
    local sum=0

    # Loop through the array and calculate the sum
    for number in "${numbers[@]}"; do
        sum=$((sum + number))
    done

    echo "Sum: $sum"
}

# Prompt the user to enter numbers
read -p "Enter the numbers (space-separated): " input

# Split the input into an array of numbers
IFS=" " read -r -a numbers <<< "$input"

# Calculate the sum
calculate_sum "${numbers[@]}"



# Function to perform subtraction
subtraction() {
  echo "Enter the first number:"
  read num1
  echo "Enter the second number:"
  read num2
  result=$(expr $num1 - $num2)
  echo "Result: $result"
}

# Function to perform multiplication
multiplication() {
  echo "Enter the first number:"
  read num1
  echo "Enter the second number:"
  read num2
  result=$(expr $num1 \* $num2)
  echo "Result: $result"
}

# Function to perform division
division() {
  echo "Enter the first number:"
  read num1
  echo "Enter the second number:"
  read num2
  result=$(expr $num1 / $num2)
  echo "Result: $result"
}


arithmetic(){

while true; do
  echo "Calculator Menu:"
  echo "1. Addition"
  echo "2. Subtraction"
  echo "3. Multiplication"
  echo "4. Division"
  echo "5. Exit"
  echo "Enter your choice (1-5):"
  read choice

  case $choice in
    1) addition;;
    2) subtraction;;
    3) multiplication;;
    4) division;;
    5) exit;;
    *) echo "Invalid choice. Please enter a number from 1 to 5.";;
  esac

  echo
done

}
# Main menu
while true; do
  echo "Calculator Menu:"
  echo "1. Addition"
  echo "2. Subtraction"
  echo "3. Multiplication"
  echo "4. Division"
  echo "5. Square"
  echo "6. Exit"
  echo "Enter your choice (1-6):"
  read choice

  case $choice in
    1) addition;;
    2) subtraction;;
    3) multiplication;;
    4) division;;
    5) exit;;
    *) echo "Invalid choice. Please enter a number from 1 to 5.";;
  esac

  echo
done
