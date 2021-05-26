rng-tools:
  pkg:
    - installed

rngd service:
  service.running:
    - name: rngd
    - enable: True