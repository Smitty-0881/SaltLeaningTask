#setting variblae for dnsmasq.config file#
{% set dnsmasqconfig = '/etc/dnsmasq.conf' %}
{% set hosts = '/etc/hosts' %}

#Uncommenting out all required options in the dnsmasq configuration file#
dnsmasq-domain-need:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#domain-needed'
    - repl: domain-needed
    - append_if_not_found: True

dnsmasq-bogus-priv:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#bogus-priv'
    - repl: bogus-priv
    - append_if_not_found: True

dnsmasq-strict-order:
  file.replace:
    - name: {{ dnsmasqconfig }}
    - pattern: '^#strict-order'
    - repl: strict-order
    - append_if_not_found: True

dnsmasq-expand-hosts:
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
  - separator: ' = '
  - append_if_not_found: true

dnsmasq config domain:
  file.keyvalue:
  - name: {{ dnsmasqconfig }}
  - key: domain
  - value: srv.world
  - separator: ' = '
  - append_if_not_found: true

#start and enable dnsmasq#
start dnsmasq:
  cmd.run:
    - name: systemctl start dnsmasq

enable dnsmasq:
  cmd.run:
    - name: systemctl enable dnsmasq

#adding DNS records to the /etc/hosts file#
dnsmasq config hosts:
  file.keyvalue:
  - name: {{ hosts }}
  - key: 10.0.0.30
  - value: dlp.srv.world dlp
  - separator: '  '
  - append_if_not_found: true

#restart dnsmasq service#
restart dnsmasq:
  cmd.run:
    - name: systemctl restart dnsmasq