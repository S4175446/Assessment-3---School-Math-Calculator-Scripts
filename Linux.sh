#!/bin/bash

# Define the log file path
LOGFILE="/mnt/d/RMIT/Sem1 2026/Create Script for Networking/Ass3-Project2/scripts/Linux.log"

# Standardize date format for the log entry
echo "=== Update started at $(date) ===" >> "$LOGFILE"

# Run the update and upgrade commands, redirecting all output to the log file
apt-get update -y >> "$LOGFILE" 2>&1
apt-get upgrade -y >> "$LOGFILE" 2>&1

echo "=== Update finished at $(date) ===" >> "$LOGFILE"
echo "----------------------------------------" >> "$LOGFILE"
