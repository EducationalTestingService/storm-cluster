FROM docker.io/library/amazonlinux:latest

MAINTAINER Slava Andreyev <sandreyev@ets.org>

RUN yum update -y \
    && yum install -y procps-ng shadow-utils sudo bzip2 findutils git \
           hostname iproute tar unzip wget which libnsl libxcrypt-compat \
    && yum clean all

RUN useradd appuser \
    && usermod -aG wheel appuser \
    && mkdir -p /etc/sudoers.d \
    && bash -c 'echo "appuser  ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appuser' \
    && ls -la /etc/sudoers.d/ \
    && printf "appuser:%s\n" "$(uuidgen)" | chpasswd \
    && rm -f /etc/localtime \
    && ln -s /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /apps /media/logs \
    && chmod 1777 /apps /media/logs

WORKDIR /apps

# Specify the user which should be used to execute all commands below
USER appuser

RUN : install miniconda and put it in PATH \
    && curl -L https://github.com/conda-forge/miniforge/releases/download/23.3.1-1/Mambaforge-23.3.1-1-Linux-x86_64.sh > miniforge.sh \
    && bash miniforge.sh -b -p miniconda \
    && rm -f miniforge.sh \
    && export PATH=$PWD/miniconda/bin:$PATH \
    # create storm cluster
    && mamba create -y -c ets -c conda-forge -p storm-cluster-env 'storm-cluster>=1.1.6' \
    # add mamba to storm cluster
    && export PATH=$PWD/miniconda/bin:$PATH \
    && mamba install -y -p storm-cluster-env -c conda-forge mamba \
    # Clean up
    && rm -fr miniconda \
    && rm -fr ~/.cache/pip \
    && rm -fr ~/.m2 ~/.lein

# Set the working directory to user home directory
WORKDIR /home/appuser

# Export ports needed to access cluster services
# Storm main REST API port
EXPOSE 7503
# Storm log viewer port
EXPOSE 7505
# Web REST API port
EXPOSE 7580
# ActiveMQ UI port
EXPOSE 9161
# Stomp port
EXPOSE 51513
# JMS (Java Message Service) port
EXPOSE 51515
