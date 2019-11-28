# cannot use alpine as the sh -c go generate calls do not have the correct environment
FROM golang:1.13.4

ENV VERSION=0.6.0
ENV HOME /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget make git unzip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /go/src/github.com/openconfig \
    && wget -c https://github.com/openconfig/ygot/archive/v${VERSION}.tar.gz -O - | tar -xz -C /tmp \
    && mv /tmp/ygot-${VERSION} /go/src/github.com/openconfig/ygot

WORKDIR /go/src/github.com/openconfig/ygot

# need to copy installed protos so that there found in go generate
RUN sh ./scripts/install_protobuf.sh && cp -R /root/protobuf/include/* /go/src/

ENV PATH="$PATH:/root/protobuf/bin"

RUN go get -u golang.org/x/tools/cmd/goimports \
    && go get -u github.com/golang/protobuf/protoc-gen-go \
    && make install

RUN go install github.com/openconfig/ygot/generator 

WORKDIR /data

CMD ["generator", "-h"]