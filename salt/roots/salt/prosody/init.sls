prosody:
  pkg:
    - installed
  service:
    - running
    - watch:
       - pkg: nginx
       - file: /etc/prosody/prosody.cfg.lua
       - file: /etc/prosody/plugins/mod_register_from_component.lua

/etc/prosody/prosody.cfg.lua:
  file.managed:
    - source: salt://prosody/conf/prosody.cfg.lua

/etc/prosody/plugins/mod_register_from_component.lua:
  file.managed:
    - source: salt://prosody/plugins/mod_register_from_component.lua
