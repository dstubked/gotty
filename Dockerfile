FROM ubuntu:latest

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

RUN apt-get -y update && \
    apt-get install -y curl iputils-ping && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*


COPY /run_gotty.sh /run_gotty.sh

RUN chmod 744 /run_gotty.sh

RUN mkdir /home/gotty
RUN addgroup gotty
RUN useradd -g gotty gotty
RUN chown gotty:gotty /home/gotty
USER gotty

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "/run_gotty.sh"]
