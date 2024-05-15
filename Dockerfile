FROM python:3.9

LABEL "com.github.actions.name"="VulnAlerts"
LABEL "com.github.actions.description"="Daily customized CVE Alerts straight to your Slack Inbox for Free."
LABEL "version"="1.0"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="blue"
LABEL "repository"="https://github.com/sholguin/vulnalerts"
LABEL "homepage"="https://github.com/sholguin/vulnalerts"

COPY requirements.txt ./
COPY cpe.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN apt update 
RUN apt update 
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY README.md main.py entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
