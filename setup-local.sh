#!/bin/bash
#==============================================================================
# This script sets up a local development environment for the project.
#==============================================================================

# Helper function to print section headers
print_section() {
  echo
  echo "╔══════════════════════════════════════════════╗"
  echo "║ $1"
  echo "╚══════════════════════════════════════════════╝"
  echo
}

# Setup environment variables
setup_environment() {
  print_section "Setting up environment"

  if [ ! -f .env ]; then
    echo "📝 Creating environment file..."
    cp .env.example .env
    echo "✅ Environment file created."
  else
    echo "✅ Environment file already exists. Skipping creation."
  fi
}

# Setup database with Docker
setup_database() {
  print_section "Setting up database"

  if [ ! -f .env ]; then
    echo "❌ Environment file not found. Please create it first."
    exit 1
  fi

  echo "🔄 Setting up database..."
  if docker-compose up -d --build; then
    echo "✅ Database setup completed."
  else
    echo "❌ Failed to set up database."
    exit 1
  fi
}

# Install project dependencies
setup_dependencies() {
  print_section "Setting up dependencies"

  echo "📦 Installing NPM packages..."
  if npm install; then
    echo "✅ Dependencies installed successfully."
  else
    echo "❌ Failed to install dependencies."
    exit 1
  fi
}

# Start the development server
start_dev_server() {
  print_section "Starting development server"
  echo "🚀 Launching development server..."
  npm run dev
}

# Main script execution
print_section "Setting up local development environment"
setup_environment
setup_database
setup_dependencies
print_section "Local development environment setup completed"

# Ask if user wants to start the development server
read -p "Do you want to start the development server? (y/n): " start_server
if [[ "$start_server" =~ ^[Yy]$ ]]; then
  start_dev_server
else
  echo "🔹 You can start the application later using: npm run dev"
fi


