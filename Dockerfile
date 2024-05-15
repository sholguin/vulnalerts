FROM python:3-bullseye

LABEL "com.github.actions.name"="VulnAlerts"
LABEL "com.github.actions.description"="Daily customized CVE Alerts straight to your Slack Inbox for Free."
LABEL "version"="1.0"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="blue"
LABEL "repository"="https://github.com/sholguin/vulnalerts"
LABEL "homepage"="https://github.com/sholguin/vulnalerts"

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    wget

# Install OpenSSL from source
RUN wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz && \
    tar -xf openssl-1.1.1l.tar.gz && \
    cd openssl-1.1.1l && \
    ./config && \
    make && \
    make install

# Cleanup
RUN rm -rf openssl-1.1.1l openssl-1.1.1l.tar.gz

# Set environment variables to use the new OpenSSL
ENV LD_LIBRARY_PATH=/usr/local/ssl/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/ssl/bin:$PATH

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY README.md main.py entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
