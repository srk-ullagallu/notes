#!/bin/bash
# Function to find odd numbers within a range
find_odd_numbers() {
    read -p "Enter the range (start and end): " start end
    echo "Odd numbers between $start and $end:"
    for (( num=start; num<=end; num++ )); do
        if (( num % 2 != 0 )); then
            echo "$num"
        fi
    done
}
# Function to check if a number is prime
is_prime() {
    read -p "Enter a number to check if it's prime: " num
    if (( num < 2 )); then
        echo "$num is not a prime number."
        return
    fi
    for (( i=2; i*i<=num; i++ )); do
        if (( num % i == 0 )); then
            echo "$num is not a prime number."
            return
        fi
    done
    echo "$num is a prime number."
}
# Function to create a new user and assign permissions
create_user_and_set_permissions() {
    read -p "Enter username: " username
    sudo useradd -m "$username"
    echo "User $username created."
    read -p "Enter directory to assign permissions (e.g., /opt/mydir): " directory
    sudo mkdir -p "$directory"
    sudo chown "$username":"$username" "$directory"
    sudo chmod 755 "$directory"
    echo "Permissions set for $username on $directory."
}
# Function to check if a web server is responding
check_web_server() {
    read -p "Enter website URL (e.g., http://example.com): " url
    if curl -Is "$url" | head -n 1 | grep "200 OK" > /dev/null; then
        echo "Web server is responding."
    else
        echo "Web server is not responding."
    fi
}
# Function to delete old logs (older than N days)
delete_old_logs() {
    read -p "Enter log directory (e.g., /var/log): " log_dir
    read -p "Enter number of days to keep logs: " days
    sudo find "$log_dir" -type f -mtime +"$days" -name "*.log" -exec rm -f {} \;
    echo "Logs older than $days days deleted from $log_dir."
}
# Main menu
while true; do
    echo "Choose an option:"
    echo "1) Find Odd Numbers"
    echo "2) Check Prime Number"
    echo "3) Create User and Set Permissions"
    echo "4) Check if Web Server is Responding"
    echo "5) Delete Old Logs"
    echo "6) Exit"
    read -p "Enter choice: " choice
    case $choice in
        1) find_odd_numbers ;;
        2) is_prime ;;
        3) create_user_and_set_permissions ;;
        4) check_web_server ;;
        5) delete_old_logs ;;
        6) echo "Exiting script."; exit ;;
        *) echo "Invalid choice, try again." ;;
    esac
done