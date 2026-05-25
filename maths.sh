#!/bin/bash

# COMMENT 1: Iteration construct using a while loop to keep the calculator 
# running continuously until the user explicitly chooses to exit (Option 5).
while true; do
    echo "=== Linux Math Calculator ==="
    echo "1. Addition (+)"
    echo "2. Subtraction (-)"
    echo "3. Multiplication (*)"
    echo "4. Division (/)"
    echo "5. Exit"
    
    # Variable for storing the arithmetic operation selected by the user
    read -p "Select an option (1-5): " operation
    
    # Selection construct to handle application exit or validate initial menu choices
    if [ "$operation" -eq 5 ]; then
        echo "Exiting program. Goodbye!"
        break
    elif [ "$operation" -lt 1 ] || [ "$operation" -gt 5 ]; then
        echo "Invalid choice! Please select a number between 1 and 5."
        echo "-----------------------------------"
        continue
    fi
    
    # Variables for storing the two numbers entered by the user
    read -p "Enter first number: " num1
    read -p "Enter second number: " num2
    
    # COMMENT 2: Selection construct validating that user inputs are actual numbers 
    # using a regular expression check to prevent execution errors.
    if [[ ! "$num1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]] || [[ ! "$num2" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: Invalid numeric input. Please try again."
        echo "-----------------------------------"
        continue
    fi
    
    # COMMENT 3: Execution of sequential arithmetic operations based on user choice.
    # Employs 'bc -l' scaling to handle decimal division accurately and catch division-by-zero.
    case $operation in
        1)
            result=$(echo "$num1 + $num2" | bc -l)
            echo "Result: $num1 + $num2 = $result"
            ;;
        2)
            result=$(echo "$num1 - $num2" | bc -l)
            echo "Result: $num1 - $num2 = $result"
            ;;
        3)
            result=$(echo "$num1 * $num2" | bc -l)
            echo "Result: $num1 * $num2 = $result"
            ;;
        4)
            # Debugging check: Prevent terminal crashing due to division by zero
            if (( $(echo "$num2 == 0" | bc -l) )); then
                echo "Error: Division by zero is not allowed."
            else
                result=$(echo "scale=4; $num1 / $num2" | bc -l)
                echo "Result: $num1 / $num2 = $result"
            fi
            ;;
    esac
    echo "-----------------------------------"
done
