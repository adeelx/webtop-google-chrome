FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN apt-get update && apt-get install -y \
    wget \
    && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome.deb \
    && dpkg -i /tmp/google-chrome.deb || true \
    && apt-get install -f -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/google-chrome.deb
