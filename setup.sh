#!/bin/bash

if [ ! -d src/wp-includes ]; then
    echo "Downloading WordPress core..."
    mkdir -p src
    curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf wordpress.tar.gz -C src --strip-components=1
    rm wordpress.tar.gz
    echo "✅ WordPress download completed."
else
    echo "✅ WordPress already installed."
fi