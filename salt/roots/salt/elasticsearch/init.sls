elasticsearch-1_3:
  pkgrepo.managed:
    - humanname: ElasticSearch
    - name: deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - require_in:
      - pkg: elasticsearch

  pkg.latest:
    - name: elasticsearch
    - refresh: True

openjdk-7-jdk:
  pkg.latest


elasticsearch:
  pkg:
    - installed
  service:
   - running
   - require:
     - pkg: openjdk-7-jdk
   - watch:
     - file: /etc/elasticsearch/elasticsearch.yml


/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://elasticsearch/lib/elasticsearch.yml
    - mode: 644
    - template: jinja
    - master_nodes: ["192.168.50.4"]
