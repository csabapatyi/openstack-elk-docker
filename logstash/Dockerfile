FROM docker.elastic.co/logstash/logstash:5.4.0
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
USER root
RUN chown -R logstash:logstash /usr/share/logstash/
USER logstash