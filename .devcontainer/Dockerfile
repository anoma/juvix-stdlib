# OS
ARG VARIANT="ubuntu-22.04"

FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    curl \
    sudo \
    wget \
    git \
    make \
    cmake \
    clang \
    lldb \
    lld \
    llvm \
    rsync \
    build-essential \
    lsb-release \
    pkg-config \
    software-properties-common \
    autoconf && apt-get clean

ENV PATH=${PATH}:/home/vscode/.local/bin
RUN sudo bash -c 'mkdir -p /home/vscode/.local/bin'
RUN sudo bash -c "chown -R vscode /home/vscode/.local/"
RUN sudo bash -c 'chmod -R a+rXw /home/vscode/.local'

RUN sudo bash -c 'curl https://get.wasmer.io -sSfL | sudo WASMER_DIR=/home/vscode/.local sh'

# to be used by the juvix extension
RUN sudo bash -c 'mkdir -p /home/vscode/.local/juvix'

RUN sudo bash -c 'curl -s https://api.github.com/repos/anoma/juvix-nightly-builds/releases/latest \
      | grep -a "browser_download_url.*linux" \
      | cut -d : -f 2,3 \
      | tr -d \" \
      | wget --output-document juvix.tar.gz -qi - \
      && tar xfv juvix.tar.gz --directory=/home/vscode/.local/bin/'

RUN sudo bash -c 'mkdir -p /home/vscode/.local/wasi-sysroot'
RUN sudo bash -c 'curl -s https://api.github.com/repos/WebAssembly/wasi-sdk/releases/tags/wasi-sdk-16 \
      | grep -a "browser_download_url.*wasi-sysroot-16.*tar.gz" \
      | cut -d : -f 2,3 \
      | tr -d \" \
      | wget --output-document wasi-sysroot.tar.gz -qi - \
      && tar xvf wasi-sysroot.tar.gz --directory /home/vscode/.local/wasi-sysroot/'
ENV WASI_SYSROOT_PATH=/home/vscode/.local/wasi-sysroot/
