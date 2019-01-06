FROM  openjdk:8-jdk
RUN apt-get update

RUN update-ca-certificates -f
RUN mkdir -p /etc/init
RUN wget -O - -o /dev/null http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i --sk=S37421#92PtARsWflw9nOT4#7kMqw35uxBSgJqKAEQ7AKytbNXTkQDKDLEG9iauN8WY=#388f
#RUN wget -O - -o /dev/null http://get.takipi.com | bash /dev/stdin -i --sk=S37421#92PtARsWflw9nOT4#7kMqw35uxBSgJqKAEQ7AKytbNXTkQDKDLEG9iauN8WY=#388f
RUN /opt/takipi/etc/takipi-setup-machine-name laernlp

RUN apt-get install -y maven

ARG maven
RUN echo $maven

RUN mkdir /root/.m2

RUN echo "$maven" >> /root/.m2/settings.xml

ADD . /code
WORKDIR /code

#RUN mvn clean install
EXPOSE 9000

#CMD mvn clean install && java -agentlib:TakipiAgent -cp target/LaerNLP-1.0-SNAPSHOT.jar:target/lib/*  ai.laer.nlp.Server
RUN mvn clean install 
#&& java -agentlib:TakipiAgent -cp target/LaerNLP-1.0-SNAPSHOT.jar:target/lib/*  ai.laer.nlp.Server
#ENTRYPOINT mvn clean install  && java -agentlib:TakipiAgent -cp target/LaerNLP-1.0-SNAPSHOT.jar:target/lib/*  ai.laer.nlp.Server
CMD java -agentlib:TakipiAgent -cp target/LaerNLP-1.0-SNAPSHOT.jar:target/lib/*  ai.laer.nlp.Server

#CMD java -cp target/LaerNLP-1.0-SNAPSHOT.jar:target/lib/*  ai.laer.nlp.Server

#ENTRYPOINT ["/bin/bash", "run.sh" ]
