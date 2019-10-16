FROM openfaas/classic-watchdog:0.18.0 as watchdog

FROM elixir:1.9-alpine

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN addgroup -S app && adduser app -S -G app

RUN mkdir -p /home/app

WORKDIR /home/app

COPY --chown=app:app cli/mix.exs ./
COPY --chown=app:app cli/lib/*.ex ./lib/

RUN MIX_ENV=prod mix escript.build

RUN chown app:app -R /home/app/elixir_function

USER app

ENV fprocess="./elixir_function"

EXPOSE 8080

CMD ["fwatchdog"]






