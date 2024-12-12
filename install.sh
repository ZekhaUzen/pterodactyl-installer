#!/bin/bash

set -e

# Pterodactyl Installer 
# Copyright Zekha 2024

output() {
  echo "* ${1}"
}

error() {
  COLOR_RED='\033[0;31m'
  COLOR_NC='\033[0m'

  echo ""
  echo -e "* ${COLOR_RED}ERROR${COLOR_NC}: $1"
  echo ""
}

# Exit with error status code if user is not root
if [[ $EUID -ne 0 ]]; then
  error "Skrip ini harus dijalankan dengan hak akses root (sudo)." 1>&2
  exit 1
fi

# Check for curl
if ! [ -x "$(command -v curl)" ]; then
  echo "* Installing dependencies."
  # Rockey / Alma
  if [ -n "$(command -v yum)" ]; then
    yum update -y >> /dev/null 2>&1
    yum -y install curl >> /dev/null 2>&1
  fi
  # Debian / Ubuntu
  if [ -n "$(command -v apt-get)" ]; then
    DEBIAN_FRONTEND=noninteractive apt update -y >> /dev/null 2>&1
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends snapd cron curl wget gzip jq >> /dev/null 2>&1
  fi
  # Check if curl is installed
  if ! [ -x "$(command -v curl)" ]; then
    echo "* curl diperlukan agar skrip ini dapat berfungsi."
    echo "* install menggunakan apt (Debian dan turunannya) atau yum/dnf (CentOS)"
    exit 1
  fi
fi

# Check for existing installation
if [ -d "/var/www/pterodactyl" ]; then
  error "Skrip mendeteksi bahwa Anda sudah memiliki panel Pterodactyl di sistem Anda!"
  output "[1] Copot pemasangan Pterodactyl - Coba hapus instalan Pterodactyl otomatis."
  output "[2] Tetap Lanjutkan - Abaikan peringatan dan tetap coba instal Pterodactyl."
  output "[3] Keluar dari Penginstal - Batalkan proses instalasi."
  
  echo -n "* Input 1-3: "
  read -r action

  case $action in
    1)
      echo "Mencoba mencopot pemasangan..."
      bash <(curl -s https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/modes/uninstall.sh)
      echo -e -n "* Pterodactyl berhasil di-uninstall, coba instal sekarang? (y/T): "
      read -r CONFIRM_PROCEED
      if [[ ! "$CONFIRM_PROCEED" =~ [Yy] ]]; then
        print_error "Instalasi dibatalkan!"
        exit 1
      fi
      ;;
    2)
      echo "Tetap mencoba untuk melanjutkan..."
      ;;
    3)
      echo "Keluar dari penginstal..."
      exit 1
      ;;
    *)
      echo "Pilihan tidak valid. Silakan masukkan angka antara 1 dan 3."
      ;;
  esac
fi

# Start install process
basic=false
standard=false
advanced=false

panel=false
wings=false
output " _____   ________ __ __  _____ "
output "/__  /  / ____/ //_// / / /   |"
output "  / /  / __/ / ,<  / /_/ / /| |"
output " / /__/ /___/ /| |/ __  / ___ |"
output "/____/_____/_/ |_/_/ /_/_/  |_|"
output "skrip instalasi Pterodactyl"
output "Skrip ini tidak terkait dengan Proyek Pterodactyl resmi. PteroInstaller sama sekali TIDAK ADA GARANSI, sejauh diizinkan oleh hukum yang berlaku."
output
output "PENOLAKAN: Penginstal ini mungkin tidak berfungsi sebagaimana mestinya di semua lingkungan."

while [ "$basic" == false ] && [ "$standard" == false ] && [ "$advanced" == false ]; do
  output "Mode instalasi apa yang ingin Anda gunakan?"
  output "[1] Penginstal Dasar - Pasang panel dan sayap pada IP Anda dengan sedikit perintah."
  # output "[2] Standard installer - Install the panel and wings with prompts for an FQDN and SSL."
  # output "[3] Advanced installer - Install either the panel or wings with options like mail configuration"

  echo -n "* Input 1: "
  read -r action

  case $action in
    1 )
      basic=true ;;
    2 )
      standard=true ;;
    3 )
      advanced=true ;;
    * )
      error "Invalid option" ;;
  esac
done

if [ "$basic" == false ] && [ "$standard" == false ]; then
  while [ "$panel" == false ] && [ "$wings" == false ]; do
    output "Apa yang ingin Anda lakukan?"
    output "[1] Install panel (Dasbor Web)"
    output "[2] Install Wings (Mesin Daemon)"
    output "[3] Instal keduanya di mesin yang sama"

    echo -n "* Input 1-3: "
    read -r action

    case $action in
      1 )
        panel=true ;;
      2 )
        wings=true ;;
      3 )
        panel=true
        wings=true ;;
      * )
        error "Invalid option" ;;
    esac
  done

  [ "$panel" == true ] && bash <(curl -s https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/modes/panel.sh)
  [ "$wings" == true ] && bash <(curl -s https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/modes/wings.sh)
elif [ "$standard" == true ]; then
  bash <(curl -s https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/modes/standard.sh)
else
  bash <(curl -s https://raw.githubusercontent.com/ZekhaUzen/pterodactyl-installer/main/modes/basic.sh)
fi
