deployable-symlink:
  file.symlink:
    - name: /home/{{ salt['pillar.get']('deployable:user') }}/latest
    - target: /home/{{ salt['pillar.get']('deployable:user') }}/deployable
