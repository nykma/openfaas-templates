FROM openfaas/classic-watchdog:0.18.0 as watchdog

FROM elixir:1.9-alpine

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN addgroup -S app && adduser app -S -G app

RUN mkdir -p /home/app/build/lib

WORKDIR /home/app/build

COPY --chown=app:app mix.exs .
COPY --chown=app:app cli.ex ./lib/
COPY --chown=app:app function/handler.ex ./lib/

RUN MIX_ENV=prod mix escript.build

RUN mv elixir_function /home/app
RUN chown app:app -R /home/app/elixir_function

WORKDIR /home/app/
USER app

ENV fprocess="./elixir_function"

EXPOSE 8080

CMD ["fwatchdog"]






