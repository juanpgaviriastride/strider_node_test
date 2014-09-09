jsvc:
  pkg.latest

elasticsearch:
  cmd.run:
    - name: dpkg -i /tmp/elasticsearch-1.3.2.deb
    - unless: dpkg -s elasticsearch
    - require:
      - file: /tmp/elasticsearch-1.3.2.deb
  service:
   - running
   - require:
     - pkg: jsvc
   - watch:
     - file: /etc/elasticsearch/elasticsearch.yml 

/tmp/elasticsearch-1.3.2.deb:
  file.managed:
    - source: salt://elasticsearch/lib/elasticsearch-1.3.2.deb
    
/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://elasticsearch/lib/elasticsearch.yml
