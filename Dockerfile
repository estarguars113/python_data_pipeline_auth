# docker build -t ubuntu1604py36
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y software-properties-common vim
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update

# install latest python version and set it as default
RUN apt-get install -y build-essential python3.7 python3.7-dev python3-pip python3.7-venv
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
RUN apt-get install -y git

# update pip
RUN python3 -m pip install pip --upgrade
RUN python3 -m pip install wheel

# install erlang as rabbitmq dependency
RUN wget -O- https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN echo "deb https://packages.erlang-solutions.com/ubuntu bionic contrib" | tee /etc/apt/sources.list.d/rabbitmq.list
RUN apt update
RUN apt -y install erlang

# install rabbitmq
RUN wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | apt-key add -
RUN wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
RUN echo "deb https://dl.bintray.com/rabbitmq/debian $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/rabbitmq.list
RUN apt update
RUN apt -y install rabbitmq-server


# create environment
RUN python3 -m venv env
RUN source env/bin/activate
RUN pip install -r provisioning/requirements.txt

