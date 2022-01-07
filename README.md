# dotfiles

Fully automated development environment for `blackglasses` at [The Alt-F4 Stream](https://www.twitch.tv/thealtf4stream) on Twitch.


![The Alt-F4 Stream][preview]


## Goals

Provide a fully automated `Manjaro with i3` development environment that should be easy to setup and maintain.


### Why Manjaro with i3?

Manjaro provides a very elegant wizard for setting up Arch Linux WITH i3-gaps (required) on machines which aligns with the goals of this repository.

Arch Linux can be setup many ways and discovery as a way to learn is highly encouraged. However, this repository is focused on being a battle-tested batteries included solution that is consistently reliable.


### Why Ansible?

Because it's awesome (only an opinion) and it replicates what we would do to setup a development environment pretty well. There are many automation solutions out there - we happen to enjoy using Ansible.


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


### Configuration

The last step before running this playbook is to configure it. This allows you to personalize your setup to your needs.

- Create a file located at `~/.config/dotfiles/values.yaml` and include your desired settings.

```bash
cd $HOME && mkdir -p .config/dotfiles && vim .config/dotfiles/values.yaml
```

#### Available Values

Below is a list of all available values. Not are all required but required values will break the playbook if not properly set.

| Name                | Type                                | Required |
| ------------------- | ----------------------------------- | -------- |
| git_user_email      | string                              | yes      |
| git_user_name       | string                              | yes      |
| exclude_roles       | array `(see group_vars/all)`        | no       |
| neovim_version      | string `(branch, tag or SHA)`       | no       |
| nitrogen_background | string `(see roles/nitrogen/files)` | no       |


### Examples

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
neovim_version: master
nitrogen_background: cats.png
```


## Usage

### Install

This playbook includes a custom shell script located at `bin/dotfiles`. This script is added to your $PATH after installation and can be run multiple times while making sure any Ansible dependencies are installed and updated.

This shell script is also used to initialize your environment after installing `Manjaro with i3`, performing a full system upgrade and creating your `~/.config/dotfiles/values.yaml` configuration file as mentioned above.

> NOTE: You must follow required steps before running this command or things may become unusable until fixed.

```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/ALT-F4-LLC/dotfiles/main/bin/dotfiles)"
```

> NOTE: This will add the `dotfiles` shell script as a command in your `$PATH`.

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
