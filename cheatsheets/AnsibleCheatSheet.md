# Ansible Notes and Tasks

## Tasks

```
  become_user: "{{ user }}"
  become: true

```  


### Add key to apt keyring
```
  apt_key:
    url: https://brave-browser-apt-release.s3.brave.com/brave-core.asc
    keyring: /etc/apt/trusted.gpg.d/brave-browser-release.gpg
    state: present
```

### Add Repository
```
  apt_repository:
    repo: deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main
    state: present
    filename: brave-browser-release.list
   update_cache: yes
```

### Install Package
```
  apt:
    name: brave-browser
    state: present
```

### Install deb package
```
  apt:  deb="/tmp/veracrypt.deb"
  when: veracrypt_installed.rc == 1
```

### update alternatives
```
 alternatives:
    name: x-terminal-emulator
    path: /usr/bin/tilix.wrapper
```

### set hostname
```
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

### Unpack Archive
```
  unarchive:
    src:     "/media/veracrypt{{ msSlot }}/user-config/{{ user }}/brave-browser/profile-{{ user }}.tgz"
    dest:    "/home/{{ user }}/"
    owner:   "{{ user }}"
    group:   "{{ user }}"
    creates: "/home/{{ user }}/.config/BraveSoftware/Brave-Browser/.ansible-idempotency-marker"

```

### Create File idempotently
```
  file:
    path:  "/home/{{ user }}/.config/BraveSoftware/Brave-Browser/.ansible-idempotency-marker"
    state: touch
    modification_time: preserve
    access_time: preserve
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




