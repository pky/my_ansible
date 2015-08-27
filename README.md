ansible
=======

my ansible playbooks

```
ansible -m setup -i inventory/dev all -K -vvvv
```

```
ansible -m setup -i inventory/localhost all -vvvv -c local
```

```
$ ansible-playbook develop.yml -i inventory/dev -K --check
```
