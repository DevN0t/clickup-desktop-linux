#!/bin/bash

# Prompt for sudo password once
sudo -v

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Change to the directory where the script is located (optional, if you want to make sure you're inside the right folder)
cd "$SCRIPT_DIR"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "npm not found. Please install Node.js and npm first."
    exit 1
fi

# Install dependencies using npm
echo "Installing dependencies..."
npm install

# Run the build to create the .AppImage
echo "Running npm run dist to create .AppImage..."
npm run dist

# Look for the .AppImage in the dist folder
APPIMAGE_FILE=$(find "$SCRIPT_DIR/dist" -name "*.AppImage" | head -n 1)

# Check if the .AppImage exists
if [ ! -f "$APPIMAGE_FILE" ]; then
    echo "The .AppImage was not found. Please make sure the build was successful."
    exit 1
fi

# Ensure the directories exist
echo "Creating necessary directories..."
sudo mkdir -p /usr/local/share/icons
sudo mkdir -p /usr/share/applications

# Download the icon
echo "Downloading the icon..."
sudo curl -L -o /usr/local/share/icons/clickup-icon.png https://github.com/DevN0t/clickup-desktop-linux/raw/master/clickup-icon.png

# Function to get the process name
get_process_name() {
  process_name=$(ps -e | grep 'clickup-linux-desktop' | awk '{print $4}')
  echo "$process_name"
}

# Get the process name if it's running
process_name=$(get_process_name)

# If the process name is not found, use the default name
if [ -z "$process_name" ]; then
  process_name="clickup-linux-desktop"
fi

# Create the .desktop file
echo "Creating the .desktop file..."
sudo bash -c "cat > /usr/share/applications/clickup-linux-desktop.desktop <<EOL
[Desktop Entry]
Version=1.0
Name=ClickUp Linux Desktop
Comment=ClickUp Web App (unofficial)
Exec=/usr/local/bin/clickup-linux-desktop
Icon=/usr/local/share/icons/clickup-icon.png
Terminal=false
Type=Application
Categories=Utility;Network;
Name[en_US]=ClickUp (unofficial)
StartupWMClass=$process_name
EOL"

# Make the .desktop file executable
echo "Making the .desktop file executable..."
sudo chmod +x /usr/share/applications/clickup-linux-desktop.desktop

# Install the .AppImage
echo "Installing the .AppImage..."
sudo cp "$APPIMAGE_FILE" /usr/local/bin/clickup-linux-desktop
sudo chmod +x /usr/local/bin/clickup-linux-desktop

echo "Installation completed successfully!"
