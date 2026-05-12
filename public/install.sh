#!/bin/bash
set -e

# 1. Detect OS and Architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

# 2. Normalize Names
if [[ "$OS" == "darwin"* ]]; then 
    OS="macos"
elif [[ "$OS" == "linux"* ]]; then 
    OS="linux"
elif [[ "$OS" == "mingw"* ]] || [[ "$OS" == "msys"* ]] || [[ "$OS" == "cygwin"* ]]; then 
    OS="windows"
fi

if [[ "$ARCH" == "arm64" ]] || [[ "$ARCH" == "aarch64" ]]; then 
    ARCH="aarch64"
else
    ARCH="x86_64"
fi

# 3. Set Extension and URL
EXTENSION="tar.gz"
if [ "$OS" = "windows" ]; then EXTENSION="zip"; fi

VERSION="latest" 
FILENAME="sui-runner-${OS}-${ARCH}.${EXTENSION}"
URL="https://github.com/MikeyA-yo/sui-runner/releases/latest/download/${FILENAME}"

# 4. Download & Install
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo "Downloading Sui-runner for ${OS} (${ARCH})..."
TMP_DIR=$(mktemp -d)
curl -L "$URL" -o "$TMP_DIR/sui-runner.${EXTENSION}"

# 5. Extraction
if [ "$EXTENSION" = "zip" ]; then
    unzip -q "$TMP_DIR/sui-runner.${EXTENSION}" -d "$TMP_DIR"
else
    tar -xzf "$TMP_DIR/sui-runner.${EXTENSION}" -C "$TMP_DIR"
fi

BINARY_NAME="sui-runner"
if [ "$OS" = "windows" ]; then BINARY_NAME="sui-runner.exe"; fi

chmod +x "$TMP_DIR/$BINARY_NAME"
mv "$TMP_DIR/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
rm -rf "$TMP_DIR"

echo "--------------------------------------------------"
echo "Sui-runner installed to $INSTALL_DIR/$BINARY_NAME"

# 6. AUTOMATIC PATH INJECTION
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    # Identify the shell config file
    SHELL_TYPE=$(basename "$SHELL")
    CONFIG_FILE=""

    if [ "$SHELL_TYPE" = "zsh" ]; then
        CONFIG_FILE="$HOME/.zshrc"
    elif [ "$SHELL_TYPE" = "bash" ]; then
        if [ "$OS" = "macos" ]; then
            CONFIG_FILE="$HOME/.bash_profile"
        else
            CONFIG_FILE="$HOME/.bashrc"
        fi
    fi

    if [ -n "$CONFIG_FILE" ]; then
        echo "Adding $INSTALL_DIR to PATH in $CONFIG_FILE"
        echo "" >> "$CONFIG_FILE"
        echo "# Sui-runner path" >> "$CONFIG_FILE"
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$CONFIG_FILE"
        
        echo "PATH updated! Please run: source $CONFIG_FILE"
    else
        echo "Could not detect shell config. Manually add $INSTALL_DIR to your PATH."
    fi
else
    echo "Run it now: sui-runner check"
fi