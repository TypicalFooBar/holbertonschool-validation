FROM ubuntu:20.04
WORKDIR /app
COPY . .

# This will stop openssh-server installer from opening a dialog
ENV DEBIAN_FRONTEND=noninteractive

# Update and install from apt
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget
RUN apt install -y curl
RUN apt install -y git
RUN apt install -y make
RUN apt install -y openssh-server
RUN apt install -y npm

# SSH
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
COPY docker.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
RUN rm docker.pub
COPY docker-image-setup-files/ssh-config /root/.ssh/config
RUN service ssh start
EXPOSE 22

# GitHub SSH key
COPY github /root/.ssh/github
COPY github.pub /root/.ssh/github.pub
RUN rm github
RUN rm github.pub

# Git config
RUN git config --global user.email dwebb.af@gmail.com
RUN git config --global user.name "Derek Webb"

# Bash profile additions
RUN echo 'eval `ssh-agent -s`' >> /root/.bashrc
RUN echo 'ssh-add ~/.ssh/github' >> /root/.bashrc

# Download Go
RUN wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
RUN rm ./go1.20.1.linux-amd64.tar.gz
# Set the path to include Go's bin directory
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc

# Download the Hugo executable
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.110.0/hugo_0.110.0_Linux-64bit.tar.gz
RUN tar -C /usr/local/bin -xzf hugo_0.110.0_Linux-64bit.tar.gz
RUN rm ./hugo_0.110.0_Linux-64bit.tar.gz

CMD ["/usr/sbin/sshd", "-D"]
