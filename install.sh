#!/bin/bash

# Check if the .AppImage already exists
if [ ! -f /usr/local/bin/clickup-linux-desktop ]; then
    echo "The .AppImage was not found. Please make sure you have run 'npm run dist' first."
    exit 1
fi

# Download the icon
echo "Downloading the icon..."
curl -L -o /usr/local/share/icons/clickup-icon.png https://github.com/SEUUSUARIO/clickup-desktop-linux/raw/main/assets/icons/clickup-icon.png

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
cat > /usr/share/applications/clickup-linux-desktop.desktop <<EOL
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
EOL

# Make the .desktop file executable
chmod +x /usr/share/applications/clickup-linux-desktop.desktop

echo "Installation completed successfully!"
