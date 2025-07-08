FROM archivebox/archivebox:0.8.5rc51

# Switch to root to install Chrome
USER root

# Install Chrome as root
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list && \
    apt update && \
    apt install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Switch back to archivebox user
USER archivebox

# Default command (can be overridden in docker-compose)
CMD ["archivebox", "server", "--quick-init", "0.0.0.0:8024"]
