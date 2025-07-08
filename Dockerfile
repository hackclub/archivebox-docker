FROM archivebox/archivebox:0.8.5rc51

# Switch to root to install Chrome
USER root

# Install Chrome as root
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg && \
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list && \
    apt update && \
    apt install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Copy custom entrypoint that handles both shell and archivebox commands
COPY --chown=root:root --chmod=755 entrypoint.sh /custom_entrypoint.sh

# Switch back to archivebox user
USER archivebox

# Use custom entrypoint that can handle shell commands
ENTRYPOINT ["dumb-init", "--", "/custom_entrypoint.sh"]
CMD ["archivebox", "server", "--quick-init", "0.0.0.0:8024"]
