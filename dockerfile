#vesrion  0.0.1
#FROM ubuntu:18.04
FROM alpine:3.7
#some_ important _library
RUN apk update && apk install wget build-essential gcc make -y
# RUN echo "echo one"
#RUN apk install common-software-properties  -y
#RUN apk install -y --no-install-recommends software-properties-common
#Install_JAVA
RUN apk install default-jdk -y openjdk-8-jre -y
# RUN apk install openjdk-8-jre -y
# RUN apk update
RUN wget -O - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
#RUN echo  "deb  http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN apk update &&  apk install elasticsearch -y
# RUN apk install git -y
# RUN apk install python2.7 -y
# RUN apk install vim  -y
#configuration_to_PubilsOverSSH
#RUN apk update && apk install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
RUN service ssh restart
RUN echo "finished"