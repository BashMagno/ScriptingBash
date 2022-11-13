function extractPorts(){#Este script esta hecho por savitar, no es mio, pero creo que junto con el mío es muy util.
    ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
    echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
    echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
    echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
    echo $ports | tr -d '\n' | xclip -sel clip
    echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
    cat extractPorts.tmp; rm extractPorts.tmp
}
function sp (){
    black='\033[1;30m'
    red='\033[1;31m'
    green='\033[1;32m'
    yellow='\033[1;33m'
    blue='\033[1;34m'
    magenta='\033[1;35m'
    cyan='\033[1;36m'
    white='\033[0m'
    
    echo -e ""
    echo -e ""
    echo -e "$red ---------------------------\n"
    echo -e "$magenta SCRIPT REALIZADO POR M4GNO\n"
    echo -e "$red ---------------------------"
    echo -e "\n"
    echo -e "$cyan"
    sudo nmap -p- --open -sV -vvv --min-rate 5000 $1 -n -Pn -oG allPorts
    echo -e "$cyan"
    echo -e "\n"
    extractPorts allPorts
    echo -e "$red --------------------------------\n"
    echo -e "$magenta SCAN A LA $1 FINALIZADO\n"
    echo -e "$red --------------------------------"
    echo -e ""
    echo -e ""
}
