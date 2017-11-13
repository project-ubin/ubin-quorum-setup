#!/bin/bash

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${MENU} 🌏  UBIN - QUORUM TOOLKIT ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NORMAL}"
    echo -e "${MENU}**Clean up/Reinstall/Resetup${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Remove installed files ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Reconfigure Quorum Network ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Full re-install ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Reinstall Qurom Network Manager ${NORMAL}"
    echo -e "${MENU}**${NORMAL}"
    echo -e "${MENU}**Quick Fix${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Stop Node ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Fix permission to 755 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Remove duplicate from path ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} Reinstall / Fix NPM  ${NORMAL}"
    echo -e ""
    echo -e "${MENU}**${NUMBER} 0)${MENU} 👌  terima kasih - 谢谢  - நன்றி  - Thank you ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

clear
show_menu
while [ opt != '0' ]
    do

    if [[ $opt = "0" ]]; then 
        break;    
	exit;
    else
        case $opt in
        1) clear;
        option_picked "Removing Installed files";
	. ./cleanup_dir.sh
        show_menu;
        ;;

        2) clear;
            option_picked "Reconfiguring Quorum Network Manager";
            cd ../QuorumNetworkManager
            cp ../setup/abc*.* .
            
	   . node index.js

	    cd ../setup
            show_menu;
            ;;

        3) clear;
            option_picked "Reinstall";
            . ./setup_full.sh;
            
            cd setup
            show_menu;
            ;;
        4) clear;
            option_picked "Reinstall Quorum Network Manager";
            cd ..
            sudo rm -rf QuorumNetworkManager
	    
	    cd setup
	    . ./install_quorumnetworkmanager.sh
	    cd ../QuorumNetworkManager
	    node index.js
#           cdir=`pwd`;
#	    sudo su - -c "cd ${cdir};cd setup; . ./install_quorumnetworkmanager.sh;"
	    cd ../setup
            show_menu;
            ;;
        5) clear;
            option_picked "Stop node";
            pkill -9 node
            show_menu;
            ;;
        6) clear;
            option_picked "Fix permission issue";
            cd ..
	    sudo chmod -R 755 *

            cd setup

            show_menu;
            ;;
        7) clear;
	    option_picked "Fix path";
	    . ./cleanup_path.sh
	   show_menu;
 	    ;;
	8) clear;
	   option_picked "Reinstall / Fix npm";
. ./install_npm.sh	   
 #         sudo apt-get update
 #          sudo apt install npm
	   
 # 	   curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
 #	   sudo apt-get install -y nodejs
 #	   sudo npm i -g npm
 #	   sudo chown -R $USER:$(id -gn $USER) /home/$USER/.config
 #	   sudo apt autoremove	  
           show_menu;
           ;;
	0) clear;
            option_picked "Yeah -- going home";
            break;
           exit;
            ;;

        x) break;
	exit;
        ;;

        \n) break;
	exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
