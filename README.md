# logstash runtime

This is a logstash installed and runtime base on debian6 image.

## Run

* Put your config file in /data (in container) and set the config file name to environment (key is cfg) when you start instance.
* Mount other folders you want

```
docker run -d -v ~/logs:/logs -v ~/data:/data -e cfg=apache.conf --link es:es peihsinsu/logstash-runtime
```

In this case, I mount ~/logs as /logs to collect apache log. The apache.conf file shows bellow:

```
input {
  file {
    path => "/logs/access.log"
    start_position => beginning
  }
}

filter {
  if [path] =~ "access" {
    mutate { replace => { "type" => "apache_access" } }
    grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
    }
  }
  date {
    match => [ "timestamp" , "dd/MMM/yyyy:HH:mm:ss Z" ]
  }
}

output {
  elasticsearch {
    host => es
  }
  stdout { codec => rubydebug }
}
```
