FROM ubuntu:20.04
WORKDIR /app
COPY . .

RUN /app/setup.sh

CMD make lint; make build; make unit-tests; make integration-tests; make validate