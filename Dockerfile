# BALENA_ARCH is aarch64 for RPi4 aka linux/arm64/v8 platform
FROM balenalib/aarch64-debian:bookworm-build

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

# Add the test pieces back:
CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: https://balena.io/docs"]

 RUN curl -SLO "https://raw.githubusercontent.com/balena-io-library/base-images/613d8e9ca8540f29a43fddf658db56a8d826fffe/scripts/assets/tests/test-stack@golang.sh" \
  && echo "Running test-stack@golang" \
  && chmod +x test-stack@golang.sh \
  && bash test-stack@golang.sh \
  && rm -rf test-stack@golang.sh 

RUN [ ! -d /.balena/messages ] && mkdir -p /.balena/messages; echo 'Here are a few details about this Docker image (For more information please visit https://www.balena.io/docs/reference/base-images/base-images/): \nArchitecture: ARM v8 \nOS: Debian Bookworm \nVariant: build variant \nDefault variable(s): UDEV=off \nThe following software stack is preinstalled: \nGo v1.20.1 \nExtra features: \n- Easy way to install packages with `install_packages <package-name>` command \n- Run anywhere with cross-build feature  (for ARM only) \n- Keep the container idling with `balena-idle` command \n- Show base image details with `balena-info` command' > /.balena/messages/image-info
