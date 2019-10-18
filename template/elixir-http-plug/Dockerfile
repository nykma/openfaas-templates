FROM openfaas/classic-watchdog:0.18.0 as watchdog

FROM elixir:1.9-alpine as builder

ENV MIX_ENV=prod

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN mkdir -p /elixir/src/lib

WORKDIR /elixir/src/

COPY mix.* ./
COPY config .
COPY rel .
COPY *.ex ./lib/
COPY function/*.ex ./lib/

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix deps.get
RUN mix deps.compile
RUN mix release

FROM elixir:1.9-alpine

RUN addgroup -S app && adduser -S -g app app \
    && mkdir -p /home/app \
    && chown app /home/app

WORKDIR /home/app

COPY --from=builder /elixir/src/_build/prod/rel/web_server/ .
COPY --from=builder /usr/bin/fwatchdog .

RUN chown -R app /home/app

USER app
ENV fprocess="./bin/web_server start"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:4001"

CMD ["./fwatchdog"]