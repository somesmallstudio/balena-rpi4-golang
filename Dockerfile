# BALENA_ARCH is rpi
FROM balenalib/rpi-debian:bookworm-build
# Find versions here: https://go.dev/dl/

ENV GO_VERSION=1.23.1
ENV GO_SUM=faec7f7f8ae53fda0f3d408f52182d942cc89ef5b7d3d9f23ff117437d4b2d2f
ENV GOARCH=arm64
RUN mkdir -p /usr/local/go \
    && curl -SLO "https://storage.googleapis.com/golang/go$GO_VERSION.linux-$GOARCH.tar.gz" \
    && echo "$GO_SUM  go$GO_VERSION.linux-$GOARCH.tar.gz" | sha256sum -c - \
    && tar -xzf "go$GO_VERSION.linux-$GOARCH.tar.gz" -C /usr/local/go --strip-components=1 \
    && rm -f go$GO_VERSION.linux-$GOARCHta.gz

ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
