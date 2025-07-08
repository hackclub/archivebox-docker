FROM archivebox/archivebox:0.8.5rc51

# Switch to root to install Chrome
USER root

# Install Chrome as root
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg && \
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list && \
    apt update && \
    apt install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Let the entrypoint script handle user switching
# USER archivebox

# Keep the original entrypoint script that handles commands properly
CMD ["archivebox", "server", "--quick-init", "0.0.0.0:8024"]
