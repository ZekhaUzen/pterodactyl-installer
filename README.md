# Zekha Pterodactyl Installer

## Instalasi:
1) Untuk memulai, penting untuk memastikan bahwa mesin Anda baru saja diinstal ulang jika Anda telah melakukan perubahan apa pun sebelumnya. 
2) Arahkan DNS A-Record ke alamat IP VPS Anda.
3) Untuk mengunduh dan menjalankan penginstal, cukup masukkan perintah berikut ke terminal Anda dan ikuti petunjuknya:
```
bash <(curl -Ss https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/install.sh || wget -O - https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/install.sh) auto
```

## Sistem Operasi yang Kompatibel:
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
