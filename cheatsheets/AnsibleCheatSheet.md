# Ansible Notes and Tasks
## General Task Fragments
### Comment Block
```
#------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------
```
### Task Headers
```
- name: ""
  become_user: "{{ user }}"

- name: ""
  become: true

- fail:

- debug:
    var:
    msg: ""
```  
### Common conditions
```
  when: file.stat.exists 
  when: not file.stat.exists 

  when: pkg_installed.rc == 1

  when: item is exists
  when: item is defined

  changed_when: false
```  
## Package Management
### Apt Add key to apt keyring
```
- name: ""
  become: true
  apt_key:
    url: https://brave-browser-apt-release.s3.brave.com/brave-core.asc
    keyring: /etc/apt/trusted.gpg.d/brave-browser-release.gpg
    state: present
```

### Apt Add Repository
```
- name: ""
  become: true
  apt_repository:
    repo: deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main
    state: present
    filename: brave-browser-release.list
   update_cache: yes
```

### Apt Install Package
```
- name: ""
  become: true
  apt:
    pkg:
      -
  
    state: present
    cache_valid_time: 3600
    install_recommends: no
    autoremove: yes 

  register: result
  retries: 5    
  until: result is success
```
### Apt update cache & upgrade
```
- name: ""
  become: true
  apt:
    update_cache: yes
    autoclean:    yes
    autoremove:   yes
    upgrade:      full
  register: result
  retries: 5
  until: result is success
```
### Query deb package
```
- name: ""
  become: true
  command:      dpkg-query -W  
  register:     pkg_installed
  failed_when:  pkg_installed.rc > 1 
  changed_when: pkg_installed.rc == 1
```
### Install deb package
```
- name: ""
  become: true
  apt:  deb="/tmp/veracrypt.deb"
  when: pkg_installed.rc == 1
```
### Queue response to package install question
```
- name: ""
  become: true
  debconf:
    name: postfix
    question: postfix/main_mailer_type
    value: Internet Site
    vtype: select
```
### Install python package
```
- name: ""
  become: true
  pip:
    name:
      - 
      - 
```
## File & URI operations
### File Properties
```
- name: ""
  become: true
  stat:
    path: "/home/{{ user }}/"
  register: file
```
### File Operations
```
- name: ""
  become: true
  file:
    path:  "/tmp/"
    path: "{{ item }}"
  
  when: item is exists
  with_items:
    - 
- name: ""
  become: true
  file:
    src:   "{{ item.src }}"
    dest:  "{{ item.dest }}"


    owner: "{{ user }}"
    group: "{{ user }}"
    mode:  0600
    
    owner: root
    group: root
    mode:  0600

    modification_time: preserve
    access_time: preserve
    
    state: directory 
    state: link
    state: absent
    state: touch

  with_items:
    - { src: "", dest: "" }
  
    src:  "./{{ vaultroot }}/borg/ssh-keys/{{ hostname }}/{{ item.src }}"
    dest: "/root/.ssh/{{ item.dest }}"
    mode : " {{ item.mode }}"  
  with_items:
    - { src: ""  dest: "", mode: 0600 }

  when: file.stat.exists 
  when: not file.stat.exists 
  when: pkg_installed.rc == 1
```
### File copy
```
- name: ""
  become: true
  copy:
    src:    "/usr/local/Shotcut/Shotcut.desktop"
    dest:   "/home/{{ user }}/.local/share/applications/"
    backup: yes

- name: ""
  become: true
  copy:
    dest: /etc/apt/apt.conf.d/99disable-translations
    content: |
```
## Editing Files
### Replace text
```
- name: ""
  become: true
  replace:
    path:    ''
    regexp:  ''
    replace: ''
```
### Line Editing
```
- name: ""
  become: true
  lineinfile:
    path: ""
    regexp:  ''
    line: ""
    state: present
    create: yes
    mode: 0600
    insertbefore: ""
    insertafter:  ""
```
### Insert block in file
```
- name: ""
  become: true
  blockinfile:
    create: yes
    path: ""
    block: |
      #
      #
```
### Unpack Archives
```
- name: ""
  become: true
  unarchive:
    src:     ""
    dest:    ""
    owner: "{{ user }}"
    group: "{{ user }}"
    creates: ""

```
### Download file from web
```
- name: ""
  become: true
  uri:
    url:     ""
    dest:    "/tmp/"
    mode:    '0666'
    creates: "/tmp/"
  when: pkg_installed.rc == 1
  ```
## Miscellaneous Tasks
### Run script
```
- name: ""
  become: true
  script:
    cmd: /tmp/install.py
    args:
      creates: "/home/{{ user }}/"
  when: file.stat.exists
```  
### Run shell commands
```
- name: ""
  become: true
  shell: |
  register: v
  changed_when: false
```
### Run command
```
- name: ""
  become: true
  command: /usr/local/bin/create-backup.sh
  environment:
    XDG_SESSION_TYPE: x11
  args:
    - ""
    - ""
    creates: ""
```
### update alternatives
```
- name: ""
  become: true
  alternatives:
    name: x-terminal-emulator
    path: /usr/bin/tilix.wrapper
```
### set host name
```
- name: ""
  become: true
  hostname:
    name: "{{ hostname }}"
    strategy: debian
```

### deconf settings
```
 dconf:
    key:   "{{ item.key   }}"
    value: "{{ item.value }}"
    state: present
  with_items:
    #
    # Warning space at start of value is required to suppress spurious array to string conversion.
    #
    - { key: "/org/gnome/mutter/experimental-features",   value: "\"['x11-randr-fractional-scaling']\"" }
```

### Unpack Configuration Backup 
```
  unarchive:
    src:     "./{{ vaultroot }}/....."

    src:     "./vault/..../backup-{{ user }}.tgz"
    dest:    "/home/{{ user }}/"
    owner:   "{{ user }}"
    group:   "{{ user }}"
    creates: "/home/{{ user }}/.config/..../.ansible-idempotency-marker"

```
### Add item to todo list
```
- name: "todo: add item to todo list"
  become: true
  lineinfile:
    path:   "/home/{{ user }}/todo.txt"
    create: yes
    mode:   0666
    owner:  "{{ user }}"
    group:  "{{ user }}"
    regexp: "{{ item }}\n"
    line:   "{{ item }}\n"
    state: present
  with_items:
    - ""
```
### Create Impotently Marker
```
  file:
    path:  "/home/{{ user }}/.config/..../.ansible-idempotency-marker"
    state: touch
    modification_time: preserve
    access_time: preserve
```
### Passwordless sudo
```
- name: ": enable password-less sudo"
  become: true
  lineinfile:
    dest: /etc/sudoers
    line: "{{ user }} ALL=(ALL:ALL) NOPASSWD: ALL"
    state: present
```
### Mount Veracrypt Volume
```
- name: "Open secure-data vault"
  shell: "echo '{{ secureDataPassword }}'|./bin/veracrypt --non-interactive --stdin ./secure-data ./vault"
  args:
    creates: "./vault/.ansible-idempotency-marker"
  changed_when: false

```
### Set File Permissions
```
  file:
    path: "{{ item }}"
    owner: root
    group: root
    mode: '0600'
  when: item is exists
  with_items:
    - /etc/postfix/sasl_passwd
    - /etc/postfix/sasl_passwd.db
    ```

### Delete File
```
  file:
    path:  "{{ item }}"
    state: absent
  with_items:
    - "/tmp/kinto-{{ version.stdout }}"
    - "/tmp/kinto.tgz"
```

### Check File etc exist, get info about
```
   stat:
     path: "/home/{{ user }}/.config/evolution/addressbook"
   register: p
```

### Download File
```
  uri:
    url: "{{ productKinto }}"
    dest: /tmp/kinto.tgz
    mode: '0666'
    creates: "/home/{{ user }}/.config/kinto"
```

### Shell command
```
shell: "echo '{{ productKinto }}' | sed -e 's?.*/??'"
  register: version
  changed_when: false
```
```
  command: "/tmp/kinto-{{ kintoVersion }}/install/linux.sh"
  args:
    creates: "/home/{{ user }}/.config/kinto"
```

### Check if Deb package installed
```
- name: "OnlineTools: Configure Slack - check if installed"
  command:      dpkg-query -W slack-desktop
  register:     slack_installed
  failed_when:  slack_installed.rc > 1
  changed_when: slack_installed.rc == 1
  ...
  when: slack_installed.rc == 1

```

### Update Users Groups
```
  user:
    name: "{{ user }}"
    groups: "{{ userGroups }}"
    append: yes
```

### Git Checkout repo
```
  git:
    repo: https://github.com/zaphod80013/vim-profile.git
    dest: "/home/{{ user }}/Repositories/vim-profile"
    recursive: yes
  when: not p.stat.exists
```

### Create LVM snapshpot
```
  lvol:
    vg:       sys
    lv:       setup
    snapshot: snap2
    size:     20G
    shrink:   no
    state:    present
    active:   yes
  when: not p.stat.exists
```

### Copy File
```
  copy:
    src:    ./files/kinto/kinto.py
    dest:   ~/.config/kinto/kinto.py
    backup: yes
  when: not p.stat.exists
```

### Set deb package install option
```
  debconf:
    name: postfix
    question: postfix/main_mailer_type
    value: Internet Site
    vtype: select
```

### Line Edits
```
  lineinfile:
    create: yes
    path: /etc/aliases
    regexp: "{{ item.regexp }}"
    line: "{{ item.line }}"
  with_items:
    - { regexp: '^postmaster:', line: 'postmaster:   root' }
    - { regexp: '^root:',       line: 'root:         {{ hostname }}@{{ domain }}' }
```

### Insert block into File
```
  blockinfile:
    create: yes
    path: /etc/postfix/main.cf
    block: |
      #
      # outbound relay configuration
      #
      smtp_generic_maps = hash:/etc/postfix/generic
      smtp_sasl_auth_enable = yes
      smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
      smtp_sasl_security_options = noanonymous
      smtp_use_tls = yes
      smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
      header_size_limit = 4096000
      masquerade_domains =  {{ domain }}
```




