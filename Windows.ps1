# Windows.ps1
# This script prompts the user for a target directory and file extension type,
# then searches and outputs the matching results in a cleanly formatted table.

# Prompt user for inputs
$dir = Read-Host -Prompt "Enter the directory path to search (e.g., C:\Users\Public)"
$type = Read-Host -Prompt "Enter the file type extension to look for (e.g., .ps1)"

# Check if the directory path has a trailing backslash; if not, add one for safety
if (-not $dir.EndsWith("\")) {
    $dir = $dir + "\"
}

# Search and display the files using the mandatory syntax template
Get-ChildItem -Path $dir* -Filter *$type | Select-Object Name,Directory | Format-Table -AutoSize *