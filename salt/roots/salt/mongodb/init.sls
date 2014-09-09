mongodb:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/mongodb.conf

/etc/mongodb.conf:
  file.managed:
    - source: salt://mongodb/conf/mongodb.conf
    - mode: 644