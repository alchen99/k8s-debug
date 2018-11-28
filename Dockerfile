FROM alpine:3.8

LABEL maintaner="Alice Chen <alchen@apache.org>"

# Metadata
LABEL org.label-schema.vcs-url="https://github.com/alchen99/k8s-debug" \
      org.label-schema.docker.dockerfile="/Dockerfile"

RUN apk add -v --update \
      ca-certificates \
      curl \
      groff \
      jq \
      less \
      mailcap \
      python \
    && apk add -v --update -t deps py-pip \
    && pip install --upgrade awscli==1.16.40 s3cmd==2.0.2 python-magic \
    && apk del --purge deps \
    && rm -rf /var/cache/apk/* \
    && kubectlVer=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` \
    && curl -L -s https://storage.googleapis.com/kubernetes-release/release/${kubectlVer}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && heptioVer=`curl -s https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/latest | cut -d'"' -f2 | awk '{gsub(".*/v","")}1'` \
    && curl -L -s https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${heptioVer}/heptio-authenticator-aws_${heptioVer}_linux_amd64 -o /usr/local/bin/heptio-authenticator-aws \
    && chmod +x /usr/local/bin/heptio-authenticator-aws

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]

