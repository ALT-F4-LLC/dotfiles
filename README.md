# dotfiles

Neovim configuration for `blackglasses` at [The Alt-F4 Stream](https://www.twitch.tv/thealtf4stream) on Twitch.

![The Alt-F4 Stream][preview]


## Requirements

1. Dependencies must be installed before setup.

- [Arch Linux](https://archlabslinux.com/)
- [i3-gaps](https://github.com/Airblader/i3/wiki/installation)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

2. SSH public key must be added to `authorized_keys`.
3. SSH service must be started and listening on port `22` (invetory.yaml for more).

## Configuration

This playbook requires an external `values.yaml` file to be included as a runtime argument. An example runtime command is included below in the usage section.

| Name           | Value                                      |
| -------------- | ------------------------------------------ |
| feh_file       | <required> (filename from roles/feh/files) |
| git_user_email | <required>                                 |
| git_user_name  | <required>                                 |
| neovim_version | <optional>                                 |


## Useage

Run this repository as an Ansible playbook to setup/update the environment:

```
ansible-playbook -i ./inventory.yaml -e @values.yaml main.yaml
```

[preview]: https://github.com/ALT-F4-LLC/dotfiles/blob/main/TheAltF4Stream.gif "The Alt-F4 Stream"
