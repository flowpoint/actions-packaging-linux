# Debian GNU/Linux 10 (1.13.10-buster)
FROM golang:1.16-buster

ENV GO111MODULE=on
ENV CGO_ENABLED=0

# Build templater
WORKDIR "/go/src/github.com/hashicorp/crt-core-helloworld"
COPY ./ .
RUN go build -o nfpm_template
RUN cp nfpm_template /usr/local/bin/nfpm_template
RUN chmod +x /usr/local/bin/nfpm_template

# Download nfpm
RUN curl -Lo nfpm.tar.gz https://github.com/goreleaser/nfpm/releases/download/v2.13.0/nfpm_2.13.0_Linux_x86_64.tar.gz \
    && tar -xf nfpm.tar.gz \
    && cp nfpm /usr/local/bin/nfpm
RUN chmod +x /usr/local/bin/nfpm

# Copy entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# set entrypoint command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh" ]