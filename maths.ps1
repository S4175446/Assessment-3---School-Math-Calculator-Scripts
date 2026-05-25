# Windows Calculator Script (maths.ps1)

# COMMENT 1: Iteration construct using a 'do' loop for continuously running 
# the calculator program sequentially until option 5 is selected.
do {
    Write-Host "`n=== Windows PowerShell Calculator ==="
    Write-Host "1. Addition (+)"
    Write-Host "2. Subtraction (-)"
    Write-Host "3. Multiplication (*)"
    Write-Host "4. Division (/)"
    Write-Host "5. Exit"
    
    # Variable for storing the arithmetic operation selected by the user
    $operation = Read-Host "Select an option (1-5)"
    
    # Selection construct to validate input or exit early
    if ($operation -eq "5") {
        Write-Host "Exiting program. Goodbye!"
        break
    }
    
    if ($operation -notin @("1", "2", "3", "4")) {
        Write-Host "Invalid choice! Please select an option between 1 and 5."
        continue
    }
    
    # Variables for storing the two numbers entered by the user
    $rawNum1 = Read-Host "Enter first number"
    $rawNum2 = Read-Host "Enter second number"
    
    # COMMENT 2: Selection construct acting as a data validation filter. 
    # Uses type-casting try/catch blocks to ensure values are numeric.
    try {
        [double]$num1 = $rawNum1
        [double]$num2 = $rawNum2
    }
    catch {
        Write-Host "Error: Inputs must be valid numbers."
        continue
    }
    
    # COMMENT 3: Code is executed in a sequential switch statement block 
    # to find the match and perform the corresponding mathematical operation.
    switch ($operation) {
        "1" {
            $result = $num1 + $num2
            Write-Host "Result: $num1 + $num2 = $result"
        }
        "2" {
            $result = $num1 - $num2
            Write-Host "Result: $num1 - $num2 = $result"
        }
        "3" {
            $result = $num1 * $num2
            Write-Host "Result: $num1 * $num2 = $result"
        }
        "4" {
            # Debugging technique: Validating the denominator to eliminate runtime errors
            if ($num2 -eq 0) {
                Write-Host "Error: Division by zero is not allowed."
            } else {
                $result = $num1 / $num2
                Write-Host "Result: $num1 / $num2 = $result"
            }
        }
    }
    Write-Host "-----------------------------------"
} while ($true)