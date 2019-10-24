FROM openfaas/classic-watchdog:0.18.0 as watchdog

FROM julia:1.2-buster

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog


# Add non root user
RUN addgroup --system app && adduser --system app --ingroup app

WORKDIR /home/app/

COPY index.jl           .

RUN chown -R app /home/app && \
  mkdir -p /home/app/julia && chown -R app /home/app
USER app
ENV PATH=$PATH:/home/app/.local/bin:/home/app/julia/bin/
ENV JULIAPATH=$JULIAPATH:/home/app/julia

RUN mkdir -p function

WORKDIR /home/app/function/

WORKDIR /home/app/

USER root

COPY function           function

RUN chown -R app:app ./ && \
  chmod -R 777 /home/app/julia

USER app

ENV fprocess="julia index.jl"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
