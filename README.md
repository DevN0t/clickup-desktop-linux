# ClickUp Linux Desktop (Unofficial)

This is an unofficial ClickUp client for Linux. You can generate the desktop app and icon locally.

## Prerequisites

- Node.js (use version 16.x or later)
- npm
- electron-builder

## How to Generate the App Image

1. **Clone the repository** or download the source code:

    ```bash
    git clone https://github.com/DevN0t/clickup-desktop-linux.git
    cd clickup-desktop-linux
    ```

2. **Install dependencies**:

    ```bash
    npm install
    ```

3. **Build the .AppImage**:

   This will generate the `.AppImage` file locally:

    ```bash
    npm run dist
    ```

4. **Run the install script**:

   This will download the icon and generate the `.desktop` file for you.

    ```bash
    bash install.sh
    ```

5. **Find ClickUp in your applications menu**.

If you encounter any issues, feel free to open an issue on the repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for more details.
