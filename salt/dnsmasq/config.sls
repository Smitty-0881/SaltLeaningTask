#setting variblae for dnsmasq.config file#
{% set dnsmasqconfig = '/etc/dnsmasq.conf' %}
{% set hosts = '/etc/hosts' %}

#Uncommenting out all required options in the dnsmasq configuration file#
dnsmasq config domain-need:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#domain-needed'
    - repl: domain-needed
    - append_if_not_found: True

dnsmasq config bogus-priv:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#bogus-priv'
    - repl: bogus-priv
    - append_if_not_found: True

dnsmasq config strict-order:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#strict-order'
    - repl: strict-order
    - append_if_not_found: True

dnsmasq config expand-hosts:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#expand-hosts'
    - repl: expand-hosts
    - append_if_not_found: True

#adding lines to dnsmasq config#
dnsmasq config server:
  file.keyvalue:
  - name: {{ dnsmasqconfig }}
  - key: server
  - value: /server.education/10.0.0.10
  - separator: '='
  - append_if_not_found: true

dnsmasq config domain:
  file.keyvalue:
  - name: {{ dnsmasqconfig }}
  - key: domain
  - value: srv.world
  - separator: '='
  - append_if_not_found: true

#start and enable dnsmasq#
dnsmasq:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: dnsmasq

#adding DNS records to the /etc/hosts file#
dlp.srv.world dlp:
  host.present:
    - ip: 10.0.0.30
