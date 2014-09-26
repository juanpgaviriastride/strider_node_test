prosody:
  pkg:
    - installed
  service:
    - running
    - watch:
       - pkg: nginx
       - file: /etc/prosody/prosody.cfg.lua
       - file: /etc/prosody/plugins/mod_register_from_component.lua
       - file: /usr/lib/modules/mod_auth_json_http.lua

/etc/prosody/prosody.cfg.lua:
  file.managed:
    - source: salt://prosody/conf/prosody.cfg.lua

/etc/prosody/plugins/mod_register_from_component.lua:
  file.managed:
    - source: salt://prosody/plugins/mod_register_from_component.lua

/usr/lib/prosody/modules/mod_auth_json_http.lua:
  file.managed:
    - source: salt://prosody/plugins/mod_json_http.lua