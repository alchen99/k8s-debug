FROM alpine:3

LABEL maintaner="Alice Chen <alchen@apache.org>"

# Metadata
LABEL org.label-schema.vcs-url="https://github.com/alchen99/k8s-debug" \
      org.label-schema.docker.dockerfile="/Dockerfile"

ADD vimrc /etc/vimrc
ADD screenrc /etc/screenrc

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
    && curl -s "https://gist.githubusercontent.com/alchen99/19176397fffbc5b43c37fff1ea2869c1/raw/40a6abcd92cc31afd2dd3303de134e354dad9180/starship.toml" -o /root/.config/starship.toml \
    && curl -s "https://gist.githubusercontent.com/alchen99/cfe481c230d346ebc94508071fdd36bd/raw/87b14e67e585e5d6240b817af2b7184843bf3a52/.bashrc-ext" -o /root/.bashrc-ext \
    && curl -L -sS "https://gist.githubusercontent.com/alchen99/973d2e314cfd648b72bb602d54951644/raw/3cc99ae6721622e82404f1102dcf6065c7be4317/.vimrc" -o /root/.vimrc \
    && curl -L -sS "https://gist.githubusercontent.com/alchen99/4a386a801bdfe13007ba489383c4acb6/raw/f421bc31d533cf65e809059161a59c8cc556e193/.screenrc" -o /root/.screenrc \
    && curl -L -sS "https://gist.githubusercontent.com/alchen99/4b25de8fc61b69a0f9cd90a840785d81/raw/dad39ee57a1eb4c658cd3872eb1c7d0545a1a515/.tmux.conf" -o /root/.tmux.conf \
    && curl -s "https://gist.githubusercontent.com/alchen99/bf30697e99a4e0faa63dc1b69eb348cb/raw/b7346af68b9f5eabd16700e777dfe9456fc57bba/.bashrc-append" >> /root/.bashrc \
    && echo "Installing Starship.rs ..." \
    && curl -L -sS https://starship.rs/install.sh | sh -s -- --yes \
    && rm -f /usr/local/bin/*.zip \
    && cd /opt \
    && SDK_VERSION=$(curl -L -sS "https://cloud.google.com/sdk/docs/release-notes" | grep '<h2 id=' | head -n 1 | sed 's/.*data-text="\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/') \
    && echo "Installing gcloud SDK ${SDK_VERSION} ..." \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${SDK_VERSION}-linux-x86_64.tar.gz \
    && tar -xf google-cloud-cli-${SDK_VERSION}-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh --usage-reporting false --command-completion false --install-python false --quiet \
    && rm -f google-cloud-cli-*-linux-x86_64.tar.gz \
    && sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd 

VOLUME /root/.aws
VOLUME /project
WORKDIR /root
CMD ["tail", "-f", "/dev/null"]
