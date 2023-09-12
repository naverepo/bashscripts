#!/bin/bash
set -x
# Thresholds (adjust these values as needed)
CPU_THRESHOLD=90
MEMORY_THRESHOLD=90
DISK_THRESHOLD=90

# Output file for logging
LOG_FILE="system_monitor.log"

# Function to check and log CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo "$(date '+%Y-%m-%d %H:%M:%S') CPU Usage: $CPU_USAGE%" >> "$LOG_FILE"
    if [ "${CPU_USAGE%.*}" -ge "$CPU_THRESHOLD" ]; then
        echo "CPU usage exceeded $CPU_THRESHOLD% threshold!" >> "$LOG_FILE"
        send_alert "CPU"
    fi
}

# Function to check and log memory usage
check_memory() {
    MEMORY_USAGE=$(free -m | awk '/Mem/ {printf("%.2f"), $3/$2*100}')
    echo "$(date '+%Y-%m-%d %H:%M:%S') Memory Usage: $MEMORY_USAGE%" >> "$LOG_FILE"
    if [ "${MEMORY_USAGE%.*}" -ge "$MEMORY_THRESHOLD" ]; then
        echo "Memory usage exceeded $MEMORY_THRESHOLD% threshold!" >> "$LOG_FILE"
        send_alert "Memory"
    fi
}

# Function to check and log disk usage
check_disk() {
    DISK_USAGE=$(df -h / | awk '/\// {print $5}' | cut -d'%' -f1)
    echo "$(date '+%Y-%m-%d %H:%M:%S') Disk Usage: $DISK_USAGE%" >> "$LOG_FILE"
    if [ "${DISK_USAGE%.*}" -ge "$DISK_THRESHOLD" ]; then
        echo "Disk usage exceeded $DISK_THRESHOLD% threshold!" >> "$LOG_FILE"
        send_alert "Disk"
    fi
}

# Function to send an alert
send_alert() {
    SUBJECT="Alert: $1 Usage Exceeded Threshold"
    ALERT_MESSAGE="$1 usage has exceeded the threshold of $2% on $(date '+%Y-%m-%d %H:%M:%S')."
    
    # Replace 'recipient@example.com' with your email address
    echo "$ALERT_MESSAGE" | mail -s "$SUBJECT" recipient@example.com
}

# Main loop
while true; do
    check_cpu
    check_memory
    check_disk
    sleep 300  # Sleep for 5 minutes (adjust as needed)
done
