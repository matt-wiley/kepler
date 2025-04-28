generate_secure_string() {
    # Default length is 12 if not provided
    local length=${1:-12}
    local custom_chars=$2
    
    # Validate that the length is a positive integer
    if ! [[ "$length" =~ ^[1-9][0-9]*$ ]]; then
        echo "Error: Length must be a positive integer."
        return 1
    fi
    
    # Define base character set (alphanumeric)
    local chars="a-zA-Z0-9"
    
    # Include custom characters if provided
    if [ -n "$custom_chars" ]; then
        # Escape special characters that might affect tr command
        local escaped_chars=$(echo "$custom_chars" | sed 's/[]\/$*.^[]/\\&/g')
        chars="${chars}${escaped_chars}"
    fi
    
    # Generate a cryptographically secure random string
    LC_ALL=C tr -dc "$chars" < /dev/urandom | head -c "$length"
    
    # Add a newline at the end for better terminal output
    echo
}