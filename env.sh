
# Build and run the Docker container for dev / test 
alias up="docker compose -f docker-compose.yml up --build -d"

# Stop and remove the Docker container and network
alias down="docker compose -f docker-compose.yml kill && docker compose -f docker-compose.yml down"

# SSH into the Docker container (this enables testing the login shell)
alias connect="ssh -p 2222 frodo@localhost"

# Restart the Docker container with a fresh build
alias bounce="down && up"