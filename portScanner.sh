#!/bin/bash
#Este script esta hecho por savitar, no es mio, pero creo que junto con el mío es muy util.
function extractPorts(){
    ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
    echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
    echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
    echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
    echo $ports | tr -d '\n' | xclip -sel clip
    echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
    cat extractPorts.tmp; rm extractPorts.tmp
}
#Español
# La funcion portScanner realiza automáticamente la method de reconocimiento:
# (Scan SYN general > extracción de puertos > Scan específico.)
# Requiere la función 'extractPorts' de S4vitar.

#English
#PortScanner function makes an authomatized port / service recognition, using the nmap tool.
#(General SYN scan> port enumeration > Deep scan)
#Requires the 'extractPorts' function by S4vitar (Included first lines )

function portScanner (){

    grey='\033[1;30m'
    red='\033[1;31m'
    green='\033[1;32m'
    yellow='\033[1;33m'
    purple='\033[1;34m'
    magenta='\033[1;35m'
    cyan='\033[1;36m'
    white='\033[0m'
    
    ports=$(xclip -o -selection clipboard)
    
    echo -e "\n"
    echo -e "$cyan ---------------------------\n"
    echo -e "$magenta [*]$white Script by Magno\n"
    echo -e "$cyan ---------------------------"
    tput civis
    sleep 2
    echo -e "\n\n$magenta [*]$white Starting regular scan to [$1]"
    sleep 2
    clear
    echo -e "$magenta [*]$white Scaneando IP$cyan [$1]$grey\n"
    sudo nmap -sS --min-rate 5000 -p- --open -n -Pn $1 -oG puertos > /dev/null 2>&1
    echo -e "\n\n$grey This might take a bit, wait please..."
    sleep 1
    echo -e "\n\n$magenta [*]$white Scan SYN completado!"
    sleep 2
    echo -e "\n\n$grey Extracting ports"
    extractPorts puertos > /dev/null 2>&1
    sleep 2
    echo -e "\n\n$magenta [*]$white Scanning..."
    sleep 2
    clear
    echo -e "$magenta [*]$white Scanning services and ports"
    sleep 1
    echo -e "\n\n$grey This might take a bit, wait please..."
    nmap -sCV -p $ports $1 -oN scan_$1 > /dev/null 2>&1
    sleep 2
    echo -e "\n\n$magenta [*]$white Succesful scan to$cyan [$1]"
    sleep 1
    rm puertos -f
    tput cnorm
    echo -e "\n\n$yellow Result at new file: $white[scan_$1]"
}
