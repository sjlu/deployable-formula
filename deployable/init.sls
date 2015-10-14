deployable-git:
  git.latest:
    - name: https://github.com/abacuslabs/deployable
    - require:
      - pkg: git
    - rev: {{ salt['pillar.get']('deployable:version', 'master') }}
    - submodules: true
    - target: /home/{{ salt['pillar.get']('deployable:user') }}/deployable
    - user: {{ salt['pillar.get']('deployable:user') }}

deployable-repos:
  file.serialize:
    - name: /home/{{ salt['pillar.get']('deployable:user') }}/deployable/config/repos.json
    - dataset_pillar: deployable:repos
    - user: {{ salt['pillar.get']('deployable:user') }}
    - group: {{ salt['pillar.get']('deployable:user') }}
    - formatter: json
    - mode: 660

deployable-config:
  file.serialize:
    - name: /home/{{ salt['pillar.get']('deployable:user') }}/deployable/config/config.json
    - dataset_pillar: deployable:config
    - user: {{ salt['pillar.get']('deployable:user') }}
    - group: {{ salt['pillar.get']('deployable:user') }}
    - formatter: json
    - mode: 660

deployable-restart:
  cmd.wait:
    - name: ./deploy.sh
    - cwd: /home/{{ salt['pillar.get']('deployable:user') }}/deployable
    - user: {{ salt['pillar.get']('deployable:user') }}
    - watch:
      - git: deployable-git
      - file: deployable-repos
      - file: deployable-config
