# openfaas-templates
Templates for use in OpenFaaS platform

## Elixir for Classic Watchdog
### Downloading the template
```sh
faas-cli template pull https://github.com/arboricity/openfaas-templates/
```

### Using the template
``` sh
faas-cli new --lang elixir hello-elixir
```

## Elixir for new http `of-watchdog` using Plug
### Downloading the template
```
faas-cli new --lang elixir-hhtp-plug hello-elixir-http
```
### Using the template
``` sh
faas-cli new --lang elixir-http-plug hello-elixir-http
```