FROM peihsinsu/logstash

ENV cfg "logstash.conf"

WORKDIR /data

CMD /logstash-1.4.2/bin/logstash -f ${cfg}
