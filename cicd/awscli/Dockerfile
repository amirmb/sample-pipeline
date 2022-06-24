FROM alpine

RUN apk add --update --no-cache make bash jq python3 py3-pip openssh-client zip unzip && \
    pip3 install --upgrade pip && \
    pip3 install awscli

ENV AWS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

VOLUME [ "/src","/root/.aws" ]

WORKDIR /src

CMD ["aws", "--version"]