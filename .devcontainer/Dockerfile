FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -y install ssh tmux w3m git
RUN apt-get -y install build-essential cmake ninja-build clang ccache lld lldb
RUN apt-get -y install python3 python-is-python3 python3-pip python3-venv python3-dev
RUN apt-get -y install software-properties-common

RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get update
RUN apt-get -y install neovim

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb && \
	apt-get -y install ./cuda-keyring_1.1-1_all.deb && \
	rm -f ./cuda-keyring_1.1-1_all.deb
RUN apt-get update
RUN apt-get -y install cuda-toolkit

ENV PATH=/usr/local/cuda/bin:$PATH
