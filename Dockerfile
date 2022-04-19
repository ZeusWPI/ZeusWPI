FROM swipl:latest

WORKDIR /app

COPY src src

CMD swipl src/main.pl prod 5000