FROM alpine:3.8

LABEL maintaner="Alice Chen <alchen@apache.org>"

# Metadata
LABEL org.label-schema.vcs-url="https://github.com/alchen99/k8s-debug" \
      org.label-schema.docker.dockerfile="/Dockerfile"

ADD vimrc /etc/vimrc
ADD screenrc /etc/screenrc

RUN apk update \
    && apk upgrade \
    && apk add -v --update \
       bash bash-completion \
       ca-certificates \
       coreutils \
       curl \
       groff \
       htop iftop \
       jq \
       less \
       mailcap \
       screen \
       python \
       vim vimdiff \
    && apk add -v --update -t deps py-pip \
    && pip install --upgrade awscli==1.16.40 s3cmd==2.0.2 python-magic \
    && apk del --purge deps \
    && rm -rf /var/cache/apk/* \
    && kubectlVer=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` \
    && curl -L -s https://storage.googleapis.com/kubernetes-release/release/${kubectlVer}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && heptioVer=`curl -s https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/latest | cut -d'"' -f2 | awk '{gsub(".*/v","")}1'` \
    && curl -L -s https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${heptioVer}/heptio-authenticator-aws_${heptioVer}_linux_amd64 -o /usr/local/bin/heptio-authenticator-aws \
    && chmod +x /usr/local/bin/heptio-authenticator-aws \
    && sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd \
    && echo '\
       . /etc/profile ; \
       PS1='\''\[\e[01;33m\][\h \u:\[\e[01;34m\]\w\[\e[01;33m\]]\[\e[00m\]\$ '\'' ; \
       eval `dircolors -b` ; \
       alias ls="ls --color=auto" ; \
       alias ll="ls -la" ; \
       alias screendr="/usr/bin/screen -DR"; \
       alias vi="/usr/bin/vim"; \
       alias vimdiff="/usr/bin/vimdiff -O "; \
       # shorten kubectl ; \
       function kub () { \
         kubectl $@ ; \
       } ; \
       export -f kub ; \
       function k () { \
         kubectl $@ ; \
       } ; \
       export -f k ; \
       source <(kubectl completion bash) ; \
       # add completion ; \
       complete -o default -F __start_kubectl k ; \
       complete -o default -F __start_kubectl kub ; \
       ' >> /etc/bash.bashrc \
       && echo '. ~/.bashrc' > /root/.bash_profile \
       && echo '. /etc/bash.bashrc' > /root/.bashrc

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
CMD ["/bin/bash", "-l"]

