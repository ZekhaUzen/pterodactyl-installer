# Zekha Pterodactyl Installer

## Installation:
1) To get started, it's important to ensure that your machine is freshly reinstalled if you've made any changes to it beforehand. 
2) Point a DNS A-Record to your machine's IP address, such as panel.forestracks.com to 192.168.53.72.
3) To download and run the installer, simply enter the following command into your terminal and follow the prompts:
```
bash <(curl -Ss https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/install.sh || wget -O - https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/install.sh) auto
```

## Compatible Operating Systems:
| Operating System | Version | Supported          | PHP Version |
| ---------------- | ------- | ------------------ | ----------- |
| Ubuntu           | 20.04   | :white_check_mark: | 8.3         |
|                  | 22.04   | :white_check_mark: | 8.3         |
|                  | 24.04   | :white_check_mark: | 8.3         |
| Debian           | 11      | :white_check_mark: | 8.3         |
|                  | 12      | :white_check_mark: | 8.3         |
|                  | 13      | :red_circle: \*    |             |
| Rocky Linux      | 8       | :white_check_mark: | 8.3         |
|                  | 9       | :white_check_mark: | 8.3         |
| AlmaLinux        | 8       | :white_check_mark: | 8.3         |
|                  | 9       | :white_check_mark: | 8.3         |
