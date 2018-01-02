##
FROM ubuntu:16.04

MAINTAINER Qiang Li "li.qiang@gmail.com"

##
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    curl \
    git \
    openssh-client \
    sudo \
    unzip \
    wget \
    zip \
    \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxslt1.1 \
    libgtk2.0-0 \
    \
    xterm

RUN ln -sf bash /bin/sh

##
ENV LOGIN=vcap
ENV HOME /home/$LOGIN

RUN echo "Add su user $LOGIN ..." \
    && useradd -m -b /home -s /bin/bash $LOGIN \
    && echo "$LOGIN ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install additional packages
#Google Chrome
RUN wget -q -O - http://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    google-chrome-stable

##
USER $LOGIN

WORKDIR /home/$LOGIN

##
CMD ["/bin/bash"]

##