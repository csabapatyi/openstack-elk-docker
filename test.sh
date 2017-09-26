## External drivers (not working)
docker run -d -p 9200:9200 -h elasticsearch --name elasticsearch \
    -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" \
    -e "xpack.security.enabled=false" \
    -v /var/ELK-stack/elasticsearch/data1:/usr/share/elasticsearch/data \
    docker.elastic.co/elasticsearch/elasticsearch:5.5.0

docker run --rm -it -p 5044:5044 -h logstash --name logstash \
    --add-host elasticsearch:$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' elasticsearch) \
    -v /var/ELK-stack/logstash/config/:/usr/share/logstash/pipeline/ \
    docker.elastic.co/logstash/logstash:5.5.0

docker run -d -p 5601:5601 -h kibana --name kibana --add-host elasticsearch:$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' elasticsearch) -e "elasticsearch.url=elasticsearch" \
    -e "XPACK_SECURITY_ENABLED=false" docker.elastic.co/kibana/kibana:5.5.0

## Internal drivers (working)
docker run -d -p 9200:9200 -h elasticsearch --name elasticsearch \
    -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" \
    -e "xpack.security.enabled=false" \
    -v /usr/share/elasticsearch/data \
    docker.elastic.co/elasticsearch/elasticsearch:5.5.0