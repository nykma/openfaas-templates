FROM openfaas/of-watchdog:0.7.7 as watchdog

FROM elixir:1.10-alpine as builder

ENV MIX_ENV=prod

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog

RUN chmod +x /usr/bin/fwatchdog && \
    mkdir -p /elixir/src/lib && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /elixir/src/

COPY mix.* ./
COPY config .
COPY rel .
COPY *.ex ./lib/
COPY function/*.ex ./lib/

RUN mix deps.get && \
    mix deps.compile && \
    mix release

FROM elixir:1.10-alpine

WORKDIR /home/app

COPY --from=builder /elixir/src/_build/prod/rel/openfaas_service/ .
COPY --from=builder /usr/bin/fwatchdog .

RUN addgroup -S app && adduser -S -g app app \
    && mkdir -p /home/app \
    && chown -R app /home/app

USER app
ENV fprocess="./bin/openfaas_service start"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:4001"

CMD ["./fwatchdog"]
