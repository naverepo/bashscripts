#!/bin/bash
#set -x
#need to setup mail client and configure smtp server to send mail out of your terminal/server 
# Recipient's email address
recipient="username@example.com"

# Subject of the email
subject="Hello from your shell script!"

# Email body
message="This is a test email sent from a shell script."

# Send the email
echo "$message" | mail -s "$subject" "$recipient"
