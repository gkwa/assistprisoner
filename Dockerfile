FROM ubuntu:focal

WORKDIR /root

RUN apt-get -y update && apt-get -y install gpg zip unzip curl vim pass
RUN curl -Lo /tmp/learn-gpg-by-doing.zip https://gist.github.com/jan-warchol/bd6340a8b49f0033aec5fbe3e9aa10d5/archive/04779b0a88ceb16ecdf4fd59fa84b8c3e44bc7ee.zip
RUN unzip /tmp/learn-gpg-by-doing.zip -d /tmp/learn-gpg-by-doing
RUN cp /tmp/learn-gpg-by-doing/*/* /root
RUN chmod +x /root/*.sh
RUN rm -rf /tmp/learn-gpg-by-doing*
RUN version=$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep -Po '"tag_name": "\K.*?(?=")'); \
    cd /tmp; \
    curl -sLo /usr/local/src/ripgrep-${version}-x86_64-unknown-linux-musl.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/$version/ripgrep-${version}-x86_64-unknown-linux-musl.tar.gz; \
    tar xzf /usr/local/src/ripgrep-${version}-x86_64-unknown-linux-musl.tar.gz; \
    install -m 755 /tmp/ripgrep-${version}-x86_64-unknown-linux-musl/rg /usr/local/bin/rg; \
    rg --version
