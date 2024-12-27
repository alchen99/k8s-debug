FROM alpine:3

LABEL maintaner="Alice Chen <alchen@apache.org>"

# Metadata
LABEL org.label-schema.vcs-url="https://github.com/alchen99/k8s-debug" \
      org.label-schema.docker.dockerfile="/Dockerfile"

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked \
    apk update \
    && apk upgrade \
    && apk add -v --update \
       bash bash-completion \
       ca-certificates \
       coreutils \
       curl \
       font-hack-nerd \
       git \
       gnupg \
       groff \
       httpie \
       htop iftop \
       jq \
       kubectl kubectl-bash-completion \
       libc6-compat \
       less \
       mailcap \
       openssh-client \
       openssl \
       postgresql16-client \
       python3 py3-crcmod py3-openssl \
       tmux \
       tree \
       unzip \
       vim vimdiff \
       wget \
       yq-go

RUN cd /usr/local/bin \
    && mkdir /root/.config \
    && echo "Installing Starship.rs ..." \
    && curl -L -sS https://starship.rs/install.sh | sh -s -- --yes \
    && cd /opt \
    && SDK_VERSION=$(curl -L -sS "https://cloud.google.com/sdk/docs/release-notes" | grep '<h2 id=' | head -n 1 | sed 's/.*data-text="\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/') \
    && echo "Installing gcloud SDK ${SDK_VERSION} ..." \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${SDK_VERSION}-linux-x86_64.tar.gz \
    && tar -xf google-cloud-cli-${SDK_VERSION}-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh --usage-reporting false --command-completion false --install-python false --quiet \
    && rm -f google-cloud-cli-*-linux-x86_64.tar.gz \
    && curl -s "https://gist.githubusercontent.com/alchen99/bf30697e99a4e0faa63dc1b69eb348cb/raw/b7346af68b9f5eabd16700e777dfe9456fc57bba/.bashrc-append" >> /root/.bashrc \
    && sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd 

ADD vimrc /etc/vimrc
ADD screenrc /etc/screenrc
ADD tmux.conf /etc/tmux.conf
ADD bashrc-ext /root/.bashrc-ext
ADD starship.toml /root/.config/starship.toml

VOLUME /project
WORKDIR /root
CMD ["tail", "-f", "/dev/null"]
