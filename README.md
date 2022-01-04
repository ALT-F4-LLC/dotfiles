# dotfiles

Neovim configuration for `blackglasses` at [The Alt-F4 Stream](https://www.twitch.tv/thealtf4stream) on Twitch.

![The Alt-F4 Stream][preview]


## Requirements

1. Dependencies must be installed before setup.

- [Manjaro i3 Edition](https://manjaro.org/download/#i3) (OS install)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

2. Current user SSH public key must be added to `~/.ssh/authorized_keys`.
3. SSH service must be started and listening on port `22` (inventory.yaml for more).

## Extra Vars

This playbook requires an external `values.yaml` file to be included as a runtime argument. An example runtime command is included below in the usage section.

| Name                 | Value                                |
| -------------------- | ------------------------------------ |
| git_user_email       | required                             |
| git_user_name        | required                             |
| nitrogen_background  | required (from roles/nitrogen/files) |
| neovim_version       | optional                             |

### Example

Below is an example `values.yaml` file:

```yaml
---
git_user_email: foo@bar.com
git_user_name: Foo Bar
nitrogen_background: cats.png
neovim_version: master
```


## Usage

Run this repository as an Ansible playbook to setup/update the environment:

```shell
ansible-galaxy install -r requirements.yml
ansible-playbook --extra-vars @values.yaml main.yaml
```

[preview]: https://github.com/ALT-F4-LLC/dotfiles/blob/main/TheAltF4Stream.gif "The Alt-F4 Stream"
