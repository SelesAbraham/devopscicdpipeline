#vesrion  0.0.1
FROM alpine:3.7

RUN apk update
RUN apk fetch openjdk8 
RUN wget -O - https://packages.elastic.co/GPG-KEY-elasticsearch 
RUN apk update &&  apk fetch elasticsearch 
RUN apk update && \
    apk add openssh augeas && \
    mkdir -p ~root/.ssh /etc/authorized_keys && chmod 700 ~root/.ssh/ && \
    augtool 'set /files/etc/ssh/sshd_config/AuthorizedKeysFile ".ssh/authorized_keys /etc/authorized_keys/%u"' && \
    augtool 'set /files/etc/ssh/sshd_config/PermitRootLogin yes' && \
    augtool 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' && \
    augtool 'set /files/etc/ssh/sshd_config/Port 80' && \
    cp -a /etc/ssh /etc/ssh.cache && \
    ssh-keygen -A && \
    rm -rf /var/cache/apk/* && \
    #mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd
EXPOSE 80
