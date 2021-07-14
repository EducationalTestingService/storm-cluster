FROM amazonlinux

MAINTAINER Slava Andreyev <sandreyev@ets.org>

RUN yum update -y \
    && yum install -y procps-ng shadow-utils \
                      bzip2 curl git hostname iproute tar unzip wget which \
    && yum clean all

RUN --mount=type=secret,id=password \
    useradd appuser \
    && printf "appuser:%s\n" "$(cat /run/secrets/password)" | chpasswd \
    && rm -f /etc/localtime \
    && ln -s /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /apps /media/logs \
    && chmod 1777 /apps /media/logs

WORKDIR /apps

# Specify the user which should be used to execute all commands below
USER appuser

RUN : install miniconda and put it in PATH \
    && curl https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh > miniconda.sh \
    && bash miniconda.sh -b -p miniconda \
    && rm -f miniconda.sh \
    && export PATH=$PWD/miniconda/bin:$PATH \
    && conda install -p miniconda -c conda-forge mamba \

    # create storm cluster
    && conda create -y -c https://nlp.research.ets.org/etslabs -c conda-forge -p storm-cluster-env storm-cluster \
    # add mamba to storm cluster
    && export PATH=$PWD/miniconda/bin:$PATH \
    && conda install -p storm-cluster-env -c conda-forge mamba \

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
