# syntax = docker/dockerfile:experimental
# Build Container
FROM golang:1.16.0 as builder

WORKDIR /go/src/bitbucket.org/app

COPY go.mod .

RUN git config --global url."git@bitbucket.org:".insteadOf "https://bitbucket.org/"
RUN mkdir /root/.ssh/ && touch /root/.ssh/known_hosts && ssh-keyscan -t rsa bitbucket.org >> /root/.ssh/known_hosts
RUN --mount=type=secret,id=ssh,target=/root/.ssh/id_rsa go mod download

COPY . .

RUN go build -o kubernetes-exec-with-golang .


# Runtime Container
FROM alpine:3.12

RUN apk add --no-cache libc6-compat

ENV SERVICE=kubernetes-exec-with-golang \
    POSITION=BackendService \
    BACKEND_APP_HOME="/var/lib/kubernetes-exec-with-golang" \
    APP_DIR="${BACKEND_APP_HOME}/${POSITION}/${SERVICE}"

RUN mkdir -p ${HOME}/Data && \
    mkdir -p ${APP_DIR}
WORKDIR ${APP_DIR}

RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*

COPY --from=builder /go/src/bitbucket.org/app/ .

CMD ["./kubernetes-exec-with-golang"]
