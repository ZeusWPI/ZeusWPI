FROM swipl:stable

WORKDIR /app

COPY . .

CMD ["swipl", "/app/src/main.pl", "prod", "5000"]