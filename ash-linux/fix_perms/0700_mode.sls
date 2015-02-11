{% from "ash-linux/fix_perms/0700_mode.jinja" import mode_0700_files with context %}

{% for filename in mode_0700_files %}
  {% if salt['file.file_exists'](filename) %}
{{ filename }}:
  file.directory:
    - mode: 0700
  {% endif %}
{% endfor %}
