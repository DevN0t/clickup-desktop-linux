#!/bin/bash

curl -L -o /usr/local/bin/clickup-linux-desktop https://github.com/DevN0t/clickup-desktop-linux/releases/download/v1.0/clickup-linux-desktop.AppImage

chmod +x /usr/local/bin/clickup-linux-desktop

curl -L -o /usr/local/share/icons/clickup-icon.png https://github.com/DevN0t/clickup-desktop-linux/raw/main/clickup-icon.png

get_process_name() {
  process_name=$(ps -e | grep 'clickup-linux-desktop' | awk '{print $4}')
  echo "$process_name"
}

process_name=$(get_process_name)

if [ -z "$process_name" ]; then
  process_name="clickup-linux-desktop"
fi

echo "Creating archive .desktop..."
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
StartupWMClass=clickup-linux-desktop
EOL

chmod +x /usr/share/applications/clickup-linux-desktop.desktop

echo "Success"
