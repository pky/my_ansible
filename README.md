ansible
=======

my ansible playbooks

* start
```
# install xcode
$ sudo xcodebuild -license

#install homebrew
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#ansible install
$ brew update
$ brew install ansible
```


* ex)
```
$ ansible -m setup -i inventory/dev all -K -vvvv
```

```
$ ansible -m setup -i inventory/localhost all -vvvv -c local
```

とりあえず、動作確認して実際にはインストールしたくない時 --check使う
```
$ ansible-playbook develop.yml -i inventory/dev -K --check
```
