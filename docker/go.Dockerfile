ARG BASE_IMAGE=ghcr.io/kimdaekyeom/serena/serena-base:latest
FROM ${BASE_IMAGE}

USER root

ARG GO_VERSION=1.24.2
ARG GOPLS_VERSION=0.17.1
ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz" -o /tmp/go.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm -f /tmp/go.tar.gz

ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

RUN /usr/local/go/bin/go install "golang.org/x/tools/gopls@v${GOPLS_VERSION}"

LABEL org.opencontainers.image.title="serena-go"
LABEL org.opencontainers.image.description="Serena image with Go and gopls installed"
LABEL org.opencontainers.image.source="https://github.com/kimdaekyeom/serena"
