#!/bin/bash

###############################################################################
#                           TROUBLESHOOTING REPORT                            
# --------------------------------------------------------------------------- #
# Inspected By: [Your Name / Senior IT Technician]
# Inspection Date: May 25, 2026
# Total Errors Found: 4
#
# ERROR BREAKDOWN & CATEGORIES:
# 
# 1. Error Category: Syntax Error (Typo in Command Name)
#    - Description: The script used 'User@dd', which is not a valid Linux command. 
#      Linux commands are strictly case-sensitive and do not contain symbols like '@'.
#    - Solution: Corrected 'User@dd' to the standard system command 'useradd'.
#
# 2. Error Category: Syntax Error (Incorrect flag usage for Shell assignment)
#    - Description: The script passed '/bin/bash' directly without the '-s' flag. 
#      Without '-s', 'useradd' tries to interpret '/bin/bash' as the username, 
#      causing the command to break.
#    - Solution: Added the '-s' flag before '/bin/bash' and included the '-m' flag 
#      to automatically generate the user's home directory.
#
# 3. Error Category: Logic Error (Broken Password Assignment Command)
#    - Description: The 'passwd' command expects a username as an argument, not a 
#      raw password string. Running 'passwd $pwrd' tries to change the password 
#      for a user named after whatever password was entered. Furthermore, 'passwd' 
#      is an interactive command and would stall the automation script.
#    - Solution: Utilized the 'chpasswd' command via a pipe, which is the standard 
#      and safe method for script-based automation.
#
# 4. Error Category: Security/Runtime Error (Missing Root Privilege Validation)
#    - Description: Modifying user accounts and password databases requires root 
#      administrative privileges. Running this script as a normal user causes 
#      "Permission denied" errors.
#    - Solution: Added an administrative check at the top using '$EUID' to ensure 
#      the script is running with 'sudo'.
###############################################################################

# --- Step 1: Privilege Verification Check ---
# Ensures the script halts immediately if not executed with administrative authority.
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be executed with root privileges. Please use 'sudo'."
    exit 1
fi

echo "=== System Automation Account Creation Wizard ==="

# --- Step 2: Capture Variables via User Input ---
read -p "Enter Username: " user
read -p "Enter Password: " pwrd

# Validation: Block operation if fields are submitted blank
if [ -z "$user" ] || [ -z "$pwrd" ]; then
    echo "Error: Username or Password fields cannot be empty."
    exit 1
fi

# --- Step 3: Account Creation Pipeline ---
echo "Creating user account '$user' with Bash shell access..."

# Fixed Syntax: Capitalization corrected, flags added, variables properly structured
useradd -m -s /bin/bash "$user"

# Verification checkpoint for user creation
if [ $? -eq 0 ]; then
    echo "User account '$user' successfully created."
else
    echo "Critical Error: Failed to create user account '$user'."
    exit 1
fi

# --- Step 4: Secure Password Provisioning ---
# Fixed Logic: Replaced interactive 'passwd' with 'chpasswd' pipeline automation
echo "$user:$pwrd" | chpasswd

# Verification checkpoint for password mapping
if [ $? -eq 0 ]; then
    echo "Password mapped to account '$user' securely."
else
    echo "Critical Error: Failed to assign password to '$user'."
    exit 1
fi

echo "================================================="
