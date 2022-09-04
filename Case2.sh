#!/usr/bin/bash

my_input="/home/kali/Documents/case2/Planilha-case2.csv"
declare -a u
declare -a e
declare -a s
declare -a se
while IFS=, read -r usuario email senha setor;
do
    u+=("$usuario")
    e+=("$email")
    s+=("$senha")
    se+=("$setor")
done<$my_input

for index in "${!u[@]}";
do
    sudo groupadd "${se[$index]}";
    sudo useradd -g "${se[$index]}" \
                 -d "/home/${u[$index]}" \
                 -s "/bin/bash" \
                 -p "$(echo "${s[$index]}" | openssl passwd -1 -stdin)" "${u[$index]}"
done
