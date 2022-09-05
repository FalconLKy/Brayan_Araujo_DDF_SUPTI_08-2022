#!/usr/bin/bash

my_input="/home/kali/Documents/case2/Planilha-case2.csv"     #adicionar local do arquivo .csv
declare -a u
declare -a e
declare -a se
declare -a s
#declaro as variaveis 
while IFS=, read -r usuario email setor senha;       #aqui faço um separador por "," usando o IFS 
do
    u+=("$usuario")
    e+=("$email")
    se+=("$setor")
    s+=("$senha")
    #adiciono um valor do arquivo .csv para cada variavel
done<$my_input

for index in "${!u[@]}";
do
    sudo groupadd "${se[$index]}";
    sudo useradd -g "${se[$index]}" \
                 -d "/home/${u[$index]}" \
                 -s "/bin/bash" \
                 -p "$(echo "${s[$index]}" | openssl passwd -1 -stdin)" "${u[$index]}"       #encripto a senha utilizando openssl            
                 #crio usuario e grupo, e adiciono ao diretorio /home e ao /bin/bash
done
