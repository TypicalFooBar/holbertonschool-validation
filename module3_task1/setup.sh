#!/bin/bash
apt update
apt upgrade
apt install -y wget curl make

# Download Go
wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
rm ./go1.20.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Download the Hugo executable
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.110.0/hugo_0.110.0_Linux-64bit.tar.gz
RUN tar -C /usr/local/bin -xzf hugo_0.110.0_Linux-64bit.tar.gz
RUN rm ./hugo_0.110.0_Linux-64bit.tar.gz
