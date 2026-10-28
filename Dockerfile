FROM swipl:latest

WORKDIR /app

COPY src src
COPY config.pl .

CMD ["swipl", "/app/src/main.pl", "prod", "5000"]
