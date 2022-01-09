# dotfiles

Fully automated development environment for `blackglasses` at [The Alt-F4 Stream](https://www.twitch.tv/thealtf4stream) on Twitch.


![The Alt-F4 Stream][preview]


# Table of Contents

- [Goals](#goals)
  - [Why Manjaro with i3?](#why-manjaro-with-i3)
  - [Why Ansible?](#why-ansible)
- [Requirements](#requirements)
  - [Operating System](#operating-system)
  - [System Upgrade](#system-upgrade)
- [Setup](#setup)
  - [values.yaml](#valuesyaml)
    - [Environment](#environment)
      - [zsh_public](#zsh_public)
      - [zsh_private](#zsh_private)
    - [Kubernetes](#kubernetes)
      - [kubectl_config](#kubectl_config)
      - [kubectl_config_active](#kubectl_config_active)
    - [SSH Keys](#ssh-keys)
    - [System Hosts](#system-hosts)
    - [Examples](#examples)
      - [Minimal](#minimal)
      - [Advanced](#advanced)
  - [vault-password.txt](#vault-passwordtxt)
- [Usage](#usage)
  - [Install](#install)
  - [Update](#update)


## Goals

Provide fully automated `Manjaro with i3` development environment that is easy to setup and maintain.


### Why Manjaro with i3?

Manjaro provides a very elegant wizard for installing Arch Linux WITH i3-gaps (required) which aligns with the goals of this repository.


### Why Ansible?

Ansible replicates what we would do to setup a development environment pretty well. There are many automation solutions out there - we happen to enjoy using Ansible.


## Requirements


### Operating System

This Ansible playbook only supports `Manjaro with i3` distribution. This is by design to provide a consistent development expierence across hosts.

- Download [Manjaro with i3](https://manjaro.org/downloads/community/i3/)
- Install OS


### System Upgrade

Verify your `Manjaro with i3` installation has all latest packages installed before running the playbook.

```
sudo pacman -Syu
```

> NOTE: This will take some time.


## Setup

### values.yaml

The `values.yaml` file allows you to personalize your setup to your needs. Create a file located at `~/.config/dotfiles/values.yaml` and include your desired settings.

```bash
cd $HOME && mkdir -p .config/dotfiles && vim .config/dotfiles/values.yaml
```

Below is a list of all available values. Not all are required but incorrect values will break the playbook if not properly set.

| Name                  | Type                                | Required |
| -------------------   | ----------------------------------- | -------- |
| git_user_email        | string                              | yes      |
| git_user_name         | string                              | yes      |
| exclude_roles         | array `(see group_vars/all)`        | no       |
| kubectl_config        | dict `(see Kubernetes below)`       | no       |
| kubectl_config_active | string `(see Kubernetes below)`     | no       |
| neovim_version        | string `(branch, tag or SHA)`       | no       |
| nitrogen_background   | string `(see roles/nitrogen/files)` | no       |
| ssh_key               | dict `(see SSH Keys below)`         | no       |
| system_host           | dict `(see System Hosts below)`     | no       |
| zsh_public            | dict `(see Environment below)`      | no       |
| zsh_private           | dict `(see Environment below)`      | no       |


#### Environment

Manage environment variables by configuring the `zsh_public` and `zsh_private` values in `values.yaml`. See both values usecase below.

##### zsh_public

The `zsh_public` value allows you to include a dictionary of generic and unsecure key-value pairs that will be stored in a `~/.zsh_public`.

```yaml
...
zsh_public:
  MY_ENV_VAR: something
...
```

#### zsh_private

The `zsh_private` value allows you to include a dictionary of secure key-value pairs that will be stored in a `~/.zsh_private`.

```yaml
...
zsh_private:
  MY_ENV_VAR_SECRET: !vault |
    $ANSIBLE_VAULT;1.1;AES256
    62333533626436313366316235626561626635396233303730343332666466393561346462303163
    3666636638613437353663356563656537323136646137630a336332303030323031376164316562
    65333963633339323762663865363766303966643035303234376163616239663539366564396166
    3830376265316231630a623834333061393138306331653164626437623337366165636163306237
    3437
...
```

### Kubernetes

Manage `kubectl` configurations by setting the `kubectl_config` and `kubectl_config_active` values in `values.yaml`. See both values usecase below.


#### kubectl_config

You can store `kubectl` configuration files as Ansible vault secrets and then store them in your `values.yaml` as shown below:

```yaml
...
kubectl_config:
  myconfig: !vault |
    $ANSIBLE_VAULT;1.1;AES256
      62333533626436313366316235626561626635396233303730343332666466393561346462303163
      3666636638613437353663356563656537323136646137630a336332303030323031376164316562
      65333963633339323762663865363766303966643035303234376163616239663539366564396166
      3830376265316231630a623834333061393138306331653164626437623337366165636163306237
      3437
...
```

#### kubectl_config_active

You can set one of your `kubectl_config` values as the active `kubectl` configuration in your `values.yaml` as shown below:

```yaml
...
kubectl_config_active: myconfig
...
```


### SSH Keys

Manage SSH keys by setting the `ssh_key` value in `values.yaml` shown as example below:

```yaml
...
ssh_key:
  <filename>: !vault |
    $ANSIBLE_VAULT;1.1;AES256
      62333533626436313366316235626561626635396233303730343332666466393561346462303163
      3666636638613437353663356563656537323136646137630a336332303030323031376164316562
      65333963633339323762663865363766303966643035303234376163616239663539366564396166
      3830376265316231630a623834333061393138306331653164626437623337366165636163306237
      3437
...
```

> NOTE: All ssh keys will be stored at `$HOME/.ssh/<filename>`.


### System Hosts

Manage `/etc/hosts` by setting the `system_host` value in `values.yaml`.

```yaml
...
system_host:
  127.0.0.1: foobar.localhost
...
```


### Examples

Below includes minimal and advanced configuration examples. If you would like to see a more real world example take a look at [blackglasses public configuration](https://github.com/ALT-F4-LLC/dotfiles-erikreinert) repository.

#### Minimal

Below is a minimal example of `values.yaml` file:

```yaml
---
git_user_email: foo@bar.com
git_user_name: Foo Bar
```

#### Advanced

Below is a more advanced example of `values.yaml` file:

```yaml
---
git_user_email: foo@bar.com
git_user_name: Foo Bar
exclude_roles:
  - slack
kubectl_config:
  myconfig: !vault |
    $ANSIBLE_VAULT;1.1;AES256
      62333533626436313366316235626561626635396233303730343332666466393561346462303163
      3666636638613437353663356563656537323136646137630a336332303030323031376164316562
      65333963633339323762663865363766303966643035303234376163616239663539366564396166
      3830376265316231630a623834333061393138306331653164626437623337366165636163306237
      3437
kubectl_config_active: myconfig
neovim_version: master
nitrogen_background: cats.png
ssh_key: !vault |
  $ANSIBLE_VAULT;1.1;AES256
    62333533626436313366316235626561626635396233303730343332666466393561346462303163
    3666636638613437353663356563656537323136646137630a336332303030323031376164316562
    65333963633339323762663865363766303966643035303234376163616239663539366564396166
    3830376265316231630a623834333061393138306331653164626437623337366165636163306237
    3437
system_host:
  127.0.0.1: foobar.localhost
zsh_public:
  MY_PUBLIC_VAR: foobar
zsh_private:
  MY_SECRET_VAR: !vault |
    $ANSIBLE_VAULT;1.1;AES256
    62333533626436313366316235626561626635396233303730343332666466393561346462303163
    3666636638613437353663356563656537323136646137630a336332303030323031376164316562
    65333963633339323762663865363766303966643035303234376163616239663539366564396166
    3830376265316231630a623834333061393138306331653164626437623337366165636163306237
    3437
```


### vault-password.txt

The `vault-password.txt` file allows you to encrypt values with `Ansible vault` and store them securely in source control. Create a file located at `~/.config/dotfiles/vault-password.txt` with a secure password in it.

```bash
vim .config/dotfiles/vault-password.yaml
```

To then encrypt values with your vault password use the following:

```bash
$ ansible-vault encrypt_string --vault-password-file $HOME/.config/dotfiles/vault-password.txt "mynewsecret" --name "MY_SECRET_VAR"
$ cat myfile.conf | ansible-vault encrypt_string --vault-password-file $HOME/.config/dotfiles/vault-password.txt --stdin-name "myfile"
```

> NOTE: This file will automatically be detected by the playbook when running `dotfiles` command to decrypt values. Read more on Ansible Vault [here](https://docs.ansible.com/ansible/latest/user_guide/vault.html).


## Usage

### Install

This playbook includes a custom shell script located at `bin/dotfiles`. This script is added to your $PATH after installation and can be run multiple times while making sure any Ansible dependencies are installed and updated.

This shell script is also used to initialize your environment after installing `Manjaro with i3`, performing a full system upgrade and creating your `~/.config/dotfiles/values.yaml` configuration file as mentioned above.

> NOTE: You must follow required steps before running this command or things may become unusable until fixed.

```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/ALT-F4-LLC/dotfiles/main/bin/dotfiles)"
```

### Update

This repository is continuously updated with new features and settings which become available to you when updating.

To update your environment run the `dotfiles` command in your shell:

```bash
$ dotfiles
```

This will handle the following tasks:

- Verify Ansible is up-to-date
- Generate SSH keys and add to `~/.ssh/authorized_keys`
- Clone this repository locally to `~/.dotfiles`
- Verify any `ansible-galaxy` plugins are updated
- Run this playbook with the values in `~/.config/dotfiles/values.yaml`

[preview]: https://github.com/ALT-F4-LLC/dotfiles/blob/main/TheAltF4Stream.gif "The Alt-F4 Stream"
